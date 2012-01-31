#!/usr/bin/env ruby
require 'rubygems'
require 'octokit'
require 'json'
require 'grit'
require 'ostruct'
require 'pathname'
require 'logger'

$logger = Logger.new($stdout)
  
class GithubBackup

  def initialize(github)
    @github = github
  end

  def serialize_issue(issue)
    JSON.pretty_generate( issue.content )
  end

  def save_issue(dir, issue)
    file = dir + ('%04d.js' % issue.number)
    file.open('w') { |f| f.write(serialize_issue(issue)) }
    @gitrepo.add(file.to_s)
  end

  def run( orgname, local_repo )
    Dir.chdir(local_repo) do |path|
      @gitrepo = begin
        Grit::Repo.new(".")
      rescue Grit::InvalidGitRepositoryError => e
        $logger.warn "Not a git Repository, creating a new one"
        Grit::Repo.init(".")
      end

      orgdir = Pathname.new orgname
      
      repositories = @github.repositories orgname 

      repositories.each do |repo|      
        reponame = "#{orgname}/#{repo.name}"
        $logger.info "Backuping #{reponame}"
        
        if @github.has_issues? reponame
          projectdir = orgdir + repo.name
          projectdir.mkpath

          @github.on_issues(reponame) {|issue| save_issue(projectdir, issue)}
        else
          $logger.info "No issues for #{reponame}"
        end
      end

      @gitrepo.commit_index("Backup...")
      $logger.info 'Backup Finished'
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
            yield OpenStruct.new(:number => issue.number, 
                                 :content => @client.issue(reponame, issue.number))
          end
          page += 1
      end until issues.length != 10
    end
  end

  def repositories(orgname)
    @client.repositories(orgname)
  end
end