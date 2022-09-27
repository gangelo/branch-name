## ['3.2.2'] - 2022-09-27
* Changes:
  * Refactor code that patches Thor incorrect display of nested commands (subcommangs).

## ['3.2.1'] - 2022-09-27
* Changes:
  * Fix rubocop violations.
  * Miscellaneous mixin refactors.
* Bug Fixes: Fix bug that displayed subcommand help incorrectly.

## ['3.1.0'] - 2022-09-26
* Enhancements:
  * Branch names may now be created using a forward-slash (/). See the README.md file for more information.
  * The `branch-name create :format_string` option string now accepts a %u placeholder which will be replaced with the currently logged in username. See `$ branch-name help create` for more information.

## ['3.0.0'] - 2022-09-26
* Changes:
  * Default default commands to :help.
  * Remove references to system for options, folder locations, etc. These were not being used and the nature of this tool is that global options should suffice.
* Bug Fixes: Not really a branch-name bug, but patched Thor bug that displays nested subcommands incorrectly.

## ['2.2.0'] - 2022-09-24
* Enhancements:
  * Add support for `branch-name create` `-x` argument (see `branch-name help create`) which allows you to position the ticket and ticket description within the formulated branch name.
  * The `branch-name create :project_location` option string now accepts any [`Time.strftime`](`https://apidock.com/ruby/Time/strftime`) format directive.
  * Add better test coverage, although not what it should be (I'm working on it); this started a "quick and dirty" tool.
  * `branch-name create` will now create the PROJECT_LOCATION if it does not exist.
  * Update README.md file.

## ['2.1.0'] - 2022-09-22
* Enhancements: Add support for Windows clipboard. Branch names created are copied to the clibboard for macOS and Windows now.

## ['2.0.1-beta] - 2022-09-20
* Bug fixes: ticket description was not joined properly (without token separator).
