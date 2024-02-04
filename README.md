# `branch-name`

[![Ruby](https://github.com/gangelo/branch-name/actions/workflows/ruby.yml/badge.svg?refresh=1)](https://github.com/gangelo/branch-name/actions/workflows/ruby.yml)
[![GitHub version](http://badge.fury.io/gh/gangelo%2Fbranch-name.svg?refresh=6)](https://badge.fury.io/gh/gangelo%2Fbranch-name)
[![Gem Version](https://badge.fury.io/rb/branch-name.svg?refresh=6)](https://badge.fury.io/rb/branch-name)
[![](http://ruby-gem-downloads-badge.herokuapp.com/branch-name?type=total)](http://www.rubydoc.info/gems/branch-name/)
[![Documentation](http://img.shields.io/badge/docs-rdoc.info-blue.svg)](http://www.rubydoc.info/gems/branch-name/)
[![Report Issues](https://img.shields.io/badge/report-issues-red.svg)](https://github.com/gangelo/branch-name/issues)
[![License](http://img.shields.io/badge/license-MIT-yellowgreen.svg)](#license)

`branch-name` is a gem that provides a command-line interface that allows you to accomplish several tasks, tasks I *personally* find myself having to carry out every time I work on a feature branch. I created this gem *for myself*; however, you are free to use it yourself, if any of these tasks fits into your personal routine:

1. Formulate a git *feature branch name*, given a [jira](https://www.atlassian.com/software/jira) ticket and jira ticket description. **Why? Because I am constantly having to create git feature branch names that are based on jira ticket and jira ticket descriptions.**
2. Optionally create a "project" based on the *branch name* (formulated in step 1 above). **Why? Because I'm constantly having to create folders to manage files associated with the feature branches I am working on.**
3. Optionally use and manage default options that determine the git  feature branch name formulated, project greated, and default files associated with the project.**Why? Because I routinely have to create files to support the feature I am working on and associate them _with_ the feature I am working on. For example: scratch.rb to hold scratch code, snippets.rb to hold code to execute to perform redundant tasks, and readme.txt files to document things I need to remember.**

## Caveats

NOTE: This documentation assumes *macOS* and any reference to `<username>` should be assumed to equal `$ whoami` unless otherwise noted.

NOTE: This documentation makes reference to *cards* and/or *tickets*; these terms should be considered synonymous, and are used to refer to *user stories*, *tasks*, *bugs*, etc.; that is, work that is normally created against a software development team's [Jira](https://www.atlassian.com/software/jira) Project board while adhering to [Agile development methodology](https://www.atlassian.com/agile#:~:text=Agile%20is%20an%20iterative%20approach,small%2C%20but%20consumable%2C%20increments.). While `branch-name` was created to be used while practicing Agile, `branch-name` can be used outside the Agile context as well.


## Installation

    $ gem install branch-name

## Usage/Examples

### `branch-name` Help
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

### Initialize `branch-name` Configuration Files
Setting up *global* settings would be a good place to start:

```
$ branch-name config init global
#=> Configuration file (/Users/<username>/.branch-name) created
```

This creates a `.branch-name` yaml configuration file the home folder of the current user (`$ whoami` on *macOS*) with the below option defaults. The option defaults created will be used with their respective `branch-name` command indicated by the `branch-name` command name under which each option resides. You may manually alter any of the option values to suite your needs. To determine what options are available for each `branch-name` command, simply view help for that particular command. If a `branch-name` command is *not* found in the `.branch-name` config file when it is first initialized (e.g. `$ branch-name config init global #=> /Users/<username>/.branch-name`), default options for that particular `branch-name` command are not currently supported.

Below is a list of _default_ options created when initializing _global_ options; consequently, these default options will be used whenever the `branch-name create` command is executed for the user "`<username>`":

```yaml
# /Users/<username>/.branch-name
---
create:
  downcase: false
  separator: _
  format_string: "%t %d"
  project: false
  project_location: "/Users/<username>/branch-name/projects/%Y/%m (%B)"
  project_files:
  - readme.txt
  - scratch.rb
  - snippets.rb
  interactive: true
  ```

NOTE: You can manually change any of the options you wish. It is recommended that you change the default `create: project_location` to meet your needs, depending on your *os*. For example, on *macOS* you might want to change this to `"/Users/<username>/Documents"`, `"/Users/<username>/Documents/features"`, or something similar.

The `create: project_location` option string also accepts any [`Time.strftime`](`https://apidock.com/ruby/Time/strftime`) format directives.

The `create: format_string` option string can be used to position the *ticket* (`%t`) and *ticket description* (`%d`) within the branch name formulated. You can also include any other information you wish in the format string, for example: "`<username> %t %d`". However, particular characters will be stripped to formulate the branch name (see `Branch::Name::Normalizable::BRANCH_NAME_REGEX` which equates to `%r{[^/\w\x20]|_}`).

Any or all of these options can also be overwritten on the command-line. For more information:
`$ branch-name config help init`

### Creating Feature Branch Names and Projects Examples

NOTE: `branch-name create` really doesn't "create" anything (unless you use the `-p` option, in which case it will create a "project" for you); rather, `branch-name create` simply _formulates_ a suitable feature branch name given a *jira* ticket and *jira* ticket description.

NOTE: The below examples will assume the following `global` config file defaults (`$ branch-name config init global`) that have been *manually* manipulated to have the following options:

```yaml
# /Users/<username>/.branch-name
---
create:
  downcase: false
  separator: _
  format_string: "%t %d"
  project: false
  project_location: "/Users/<username>/feature-branches/%Y"
  project_files:
  - readme.txt
  - scratch.rb
  - snippets.rb
  interactive: true
  ```

This example formulates feature a branch named *lg-12345-pay-down-tech-debt-on-user-model* by converting the ticket and ticket description to lowercase (`-d`) and delimiting the feature branch name tokens with a "-" character (`-s -`). The `-p` option instructs `branch-name create` to create the project folder */Users/<username>/feature-branches/2022/lg-12345-pay-down-tech-debt-on-user-model*, and finally, the `-i false` option instructs `branch-name` to *not* prompt the user when creating projects. The aforementioned project folder will also contain the following files: readme.txt, scratch.rb and snippets.rb. In addition to this, `branch-name create` will also copy the feature brach name to the clipboard for you (macOS and Windows currently supported). This is convenient when you need to create a feature branch in github, or from the command-line.

```shell
$ branch-name create -i false -p -d -s - "Pay down tech debt on User model" LG-12345
```

NOTE: When creating projects, `branch-name` will prompt you if the `interactive` option is true (`-i`).

This example simply formulates feature a branch named *Add_create_and_destroy_session_controller_actions* and copies it to the clipboard.

```shell
$ branch-name create "Add #create and #destroy session controller actions"
```
#### Creating a Branch Name that Contains Forward-Slashes (`/`)

This can be accomplished in different ways; below are some examples,

##### Embed the forward-slashes using the configuration format-string option

Specifically, the `--format-string/-x` option.

```shell
$ branch-name create -x "%u/%t %d" "Remove debug code" UX-54321
#=> Branch name: <username>/ux-54321-remove-debug-code
...
```

##### Embed the forward-slashes in the ticket description itself

Depending on *where* you want your forward-slashes to appear, you'll have to place them appropriately:

```shell
$ branch-name create "<username>/UX-54321 Remove debug code"
#=> Branch name: <username>/ux-54321-remove-debug-code
...
```

If you want a more **pernament solution**, you can [change the configuration `format_string` string](#creating-feature-branch-names-and-projects-examples) to include forward-slashes. 

Below is an example using forward-slashes and username using the `%u` format specifier (assuming it coincides with your current username): `format_string: "%u/%t %d"`

```shell
$ branch-name create "Remove debug code" UX-54321
#=> Branch name "<username>/ux-54321-remove-debug-code"
```

Lastly, you can, of course, embed a forward-slash or any other token and hard-code (for example) a username, just like any other token. The below is an example that would result if your configuration format_string looked like `format_string: "jsmith/%t %d"`.

```shell
$ branch-name create "Remove debug code" UX-54321
#=> Branch name "jsmith/ux-54321-remove-debug-code"
```

NOTE: Project folders that are formulated (`branch-name create [-p|--project] ...`), will have any tokens comprising the project folder name delimited according to the following rules: if the `options[:separator]` option (-s) is included in `Branch::Name::Normalizable::PROJECT_FOLDER_TOKEN_SEPARATORS`, `options[:separator]` (-s) will be used as the project folder token delimiter; otherwise, `Branch::Name::Normalizable::DEFAULT_PROJECT_FOLDER_TOKEN_SEPARATOR` will be used.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/branch-name. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/branch-name/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Branch::Name project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/branch-name/blob/main/CODE_OF_CONDUCT.md).
