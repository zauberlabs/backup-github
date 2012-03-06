#!/usr/bin/env ruby
require 'rubygems'
require 'octokit'
require 'json'
require 'grit'
require 'ostruct'
require 'pathname'
require 'logger'

#Grit.debug=true

Issue = Struct.new "Issue", :number, :content
$logger = Logger.new($stdout)

class GithubBackup

  def initialize(github)
    @github = github
  end

  def serialize_issue(issue)
    JSON.pretty_generate( issue.content )
  end

  def save_issue(issue)
    File.open('%04d.js' % issue.number, "w") { |f| f.write(serialize_issue(issue)) }
  end

  def backup_gitrepo( giturl, path )
      $logger.info "Backuping #{path.to_path}"
      if path.directory?
        $logger.info "Backuping #{path.to_path} -> UPDATE"
        gritty = Grit::Git.new(path.realpath.to_path)
        gritty.fetch({:timeout=>false})
      else
        $logger.info "Backuping #{path.to_path} -> NEW"
        path.mkpath
        gritty = Grit::Git.new(".")
        gritty.clone({:mirror=>true, :timeout=>false}, giturl, path.realpath.to_path)
      end
  end

  def run( orgname, local_repo )
    @github.repositories(orgname)[0,3].each do |repo|
      reponame = "#{orgname}/#{repo.name}"
      $logger.info "Backuping #{reponame}"

      repopath = Pathname.new(local_repo) + repo.name
      repopath.mkpath

      $logger.info("Backup Reporsitory")
      backup_gitrepo(repo.ssh_url, repopath + "git-bare" )

      $logger.info("Backup Wiki")
      backup_gitrepo(repo.ssh_url.gsub(".git", ".wiki.git"), repopath + "wiki-bare" )

      # Backup Issues
      if @github.has_issues? reponame
        issuespath = repopath + "issues"
        issuespath.mkpath
        Dir.chdir(issuespath) do
          # After endless problems with Grit, fallback to sytem exec
          `git init` unless File.directory? ".git"
          $logger.info("Fetching issues")
          @github.on_issues(reponame) {|issue| save_issue(issue)}

          $logger.info("Add & Commit issues")
          `git add .`
          `git commit -m backup`
        end
      else
        $logger.info "No issues for #{reponame}"
      end
    end
  end
end


class GithubAPIAdapter
  @@ISSUE_STATES = %w{open closed}

  def initialize(client)
    @client = client
  end

  def has_issues?(reponame)
    @client.repository(reponame).has_issues
  end

  def on_issues(reponame, &block)
    @@ISSUE_STATES.each do |status|
      page = 0

      begin
          issues = @client.list_issues( reponame, :page => page, :state => status )
          issues.each do |issue|
            yield Issue.new(issue.number, @client.issue(reponame, issue.number))
          end
          page += 1
      end until issues.length != 10
    end
  end

  def repositories(orgname)
    @client.repositories(orgname)
  end
end