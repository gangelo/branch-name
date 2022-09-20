# `branch-name`

`branch-name` is a gem that provides a command-line interface that allows you to accomplish several tasks, tasks I *personally* find myself having to carry out every time I work on a feature branch. I created this gem *for myself*; however, you are free to use it yourself, if any of these tasks fits into your personal routine:

1. Formulate a git *feature branch name*, given a [jira](https://www.atlassian.com/software/jira) ticket and jira ticket description. **Why? Because I am constantly having to create git feature branch names that are based on jira ticket and jira ticket descriptions.**
2. Optionally create a "project" based on the *branch name* (formulated in step 1 above). **Why? Because I'm constantly having to create folders to manage files associated with the feature branches I am working on.**
3. Optionally use and manage default options that determine the git  feature branch name formulated, project greated, and default files associated with the project.**Why? Because I routinely have to create files to support the feature I am working on and associate them _with_ the feature I am working on. For example: scratch.rb to hold scratch code, snippets.rb to hold code to execute to perform redundant tasks, and readme.txt files to document things I need to remember.**

## Caveats

NOTE: This documentation assumes *macos* and any reference to `<username>` should be assumed to equal `$ whoami` unless otherwise noted.

NOTE: This documentation makes reference to *cards* and/or *tickets*; these terms should be considered synonymous, and are used to refer to *user stories*, *tasks*, *bugs*, etc.: work that is normally created against a software development team's [Jira](https://www.atlassian.com/software/jira) Project board while adhering to [Agile development methodology](https://www.atlassian.com/agile#:~:text=Agile%20is%20an%20iterative%20approach,small%2C%20but%20consumable%2C%20increments.). While `branch-name` was created to be used while practicing Agile, `branch-name` can be used outside the Agile context as well.


## Installation

    $ gem install branch-name

## Usage/Examples

### `branch-name` help
```shell
# Display general branch-name help
$ branch-name help

# Display help for the 'create' command
$ branch-name help create

# Display help for the 'config' command and subsommands
$ branch-name help config
$ branch-name config help info
$ branch-name config help init
$ branch-name config help delete
```

### Initialize `branch-name` configuration files
Setting up *global* settings would be a good place to start:

```
$ branch-name config init global
#=> Configuration file (/Users/<username>/.branch-name) created
```

This creates a `.branch-name` .yaml configuration file the home folder of the current user (`$ whoami` on *macos*) with the following option defaults. The option defaults created will be used with their respective `branch-name` command indicated by the `branch-name` command name under which each option resides. You may manually alter any of the option values to suite your needs. To determine what options are available for each `branch-name` command, simply view help for that particular command. If a `brnch-name` command is *not* found in the `.branch-name` confg file when it is first initialized (e.g. `$ branch-name config init global #=> /Users/<username>/.branch-name`), default options for that particular `branch-name` command is not currently supported.

For example, the following default options will be used whenever the `branch-name create` command is executed for the user "`<username>`":

```yaml
# /Users/<username>/.branch-name
---
create:
  downcase: false
  separator: _
  project: false
  project_location: "/Users/<username>"
  project_files:
  - scratch.rb
  - readme.txt
  ```

NOTE: It is recommended that you change the default `create: project_location` to a more suitable location depending on your *os*. For example, on *macos* you might want to change this to `"/Users/<username>/Documents"`, `"/Users/<username>/Documents/features"`, or something similar.

Any or all of these options can be overwritten on the command-line:

For more information:
`$ branch-name config help init`

### Creating Feature Branch Names and Projects Examples

NOTE: `branch-name create` really doesn't "create" anything (unless you use the `-p` option, in which case it will create a "project" for you); rather, `branch-name create` simply formulates a suitable feature branch name given a *jira* ticket and *jira* ticket description.

NOTE: The below examples will assume the following `global` config file defaults (`$ branch-name config init global`) that have been *manually* manipulated to have the following options:

```yaml
# /Users/<username>/.branch-name
---
create:
  downcase: false
  separator: _
  project: false
  project_location: "/Users/<username>/feature-branches/2022"
  project_files:
  - readme.txt
  - scratch.rb
  - snippets.rb
  ```

This example formulates feature a branch named *lg-12345-pay-down-tech-debt-on-user-model* by converting the ticket and ticket description to lowercase (`-d`) and delimiting the feature branch name tokens with a "-" character (`-s -`). The `-p` option instructs `branch-name create` to create the project folder */Users/<username>/feature-branches/2022/lg-12345-pay-down-tech-debt-on-user-model*. The aforementioned project folder will also contain the following files: readme.txt, scratch.rb and snippets.rb. In addition to this, `branch-name create` will also copy the feature brach name to the clipboard for you. This is convienient when you need to create a feature branch in github, or from the command-line.

```shell
$ branch-name create -p -d -s - "Pay down tech debt on User model" LG-12345
```

This example simply formulates feature a branch named *Add_create_and_destroy_session_controller_actions* and copies it to the clipboard.

```shell
$ branch-name create "Add #create and #destroy session controller actions"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/branch-name. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/branch-name/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Branch::Name project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/branch-name/blob/main/CODE_OF_CONDUCT.md).
