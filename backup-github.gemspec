# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "backup-github"
  s.version = "2.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mariano A. Cortesi"]
  s.date = "2012-03-06"
  s.description = "Command to backup Github Issues as JSON files in a Git Repository"
  s.email = "mariano@zauberlabs.com"
  s.executables = ["backup-github"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    ".rspec",
    ".rvmrc",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "backup-github.gemspec",
    "bin/backup-github",
    "lib/backup-github.rb",
    "lib/backup-github/cli.rb",
    "spec/backup-github_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.bindir = "bin"
  s.homepage = "http://github.com/zauberlabs/backup-github"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.15"
  s.summary = "Backups Github Issues"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<octokit>, ["~> 0.6.5"])
      s.add_runtime_dependency(%q<json>, ["~> 1.6.4"])
      s.add_runtime_dependency(%q<grit>, ["~> 2.4.1"])
      s.add_runtime_dependency(%q<trollop>, ["~> 1.16.2"])
      s.add_development_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8.3"])
      s.add_development_dependency(%q<mocha>, ["~> 0.10.3"])
    else
      s.add_dependency(%q<octokit>, ["~> 0.6.5"])
      s.add_dependency(%q<json>, ["~> 1.6.4"])
      s.add_dependency(%q<grit>, ["~> 2.4.1"])
      s.add_dependency(%q<trollop>, ["~> 1.16.2"])
      s.add_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.3"])
      s.add_dependency(%q<mocha>, ["~> 0.10.3"])
    end
  else
    s.add_dependency(%q<octokit>, ["~> 0.6.5"])
    s.add_dependency(%q<json>, ["~> 1.6.4"])
    s.add_dependency(%q<grit>, ["~> 2.4.1"])
    s.add_dependency(%q<trollop>, ["~> 1.16.2"])
    s.add_dependency(%q<rspec>, ["~> 2.8.0"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.3"])
    s.add_dependency(%q<mocha>, ["~> 0.10.3"])
  end
end

