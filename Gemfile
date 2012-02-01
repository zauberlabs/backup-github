source :rubygems

group :development do
  gem "rspec", "~> 2.8.0"
  gem "rdoc", "~> 3.12"
  gem "bundler", "~> 1.0.0"
  gem "jeweler", "~> 1.8.3"
  gem "mocha", "~> 0.10.3"  
  # gem "pry" # active for debug
end

group :default do
  gem "octokit", "~> 0.6.5"
  gem "json", "~> 1.6.4"
  gem "grit", "~> 2.4.1"
  gem "trollop", "~> 1.16.2"
end

# yo dawg, i herd u lieked jeweler
group :xzibit do
  # steal a page from bundler's gemspec:
  # add this directory as jeweler, in order to bundle exec jeweler and use the current working directory
  gem 'backup-github', :path => '.'
end
