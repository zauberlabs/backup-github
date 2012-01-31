require 'trollop'
require 'backup-github'

module BackupGithub
  module Cli

    def self.parse_options
      opts = Trollop::options do
        opt :localrepo, "Path to the local repository where backups are saved", 
          :short => "-r",
          :type => String,
          :required => true
        opt :organization, "Organization as known by Github", 
          :short => "-o",
          :type => String,
          :required => true
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

      walker = GithubIssuesWalker.new(
                Octokit::Client.new(
                  :login => opts[:github_user], 
                  :password => opts[:github_password]))
      GithubBackup.new(walker).run(opts[:organization], opts[:localrepo])
    end

  end
end

