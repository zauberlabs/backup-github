# backup-github

Utility tool to backup github repository issues.

It works with a local git repository, on which issues from all issues of an organization are serialized to json and commited. Thanks to git, all changes are versioned, and saved.

To install you can just download the gem with:

```bash
    gem install backup-github
```

Then, to run the backup command

```bash
    backup-github -r path/to/my/backup/dir -u github_user -p github_pwd -o github_account
```

To properly configure the backup system, we recommend setting a cron job to run the command once a day.

## Contributing to backup-github
 
* Check out the latest master to make sure the feature hasn't been implemented
  or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it 
  and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to 
  have your own version, or is otherwise necessary, that is fine, but please 
  isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2012 Zauber. See LICENSE.txt for
further details.

