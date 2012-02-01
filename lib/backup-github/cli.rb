require 'trollop'
require 'backup-github'

module BackupGithub
  module Cli

    def self.parse_options
      opts = Trollop::options do
        banner "hola mundo"
        opt :localrepo, "Path to the local repository where backups are saved", 
          :short => "-r",
          :type => String,
          :required => true
        opt :organization, "Organization name if you want to backup repositories from one", 
          :short => "-o",
          :type => String,
          :required => false
        opt :github_user, "Github User", 
          :short => "-u",
          :type => String,
          :required => true
        opt :github_password, "Github Password", 
          :short => "-p",
          :type => String,
          :required => true
      end
      Trollop::die :localrepo, "must exist" unless File.directory? opts[:localrepo]
      opts
    end

    def self.run
      opts = parse_options
      account = opts[:organization] || opts[:github_user]
      github = GithubAPIAdapter.new(
                Octokit::Client.new(
                  :login => opts[:github_user], 
                  :password => opts[:github_password]))
      GithubBackup.new(github).run(account, opts[:localrepo])
    end

  end
end

