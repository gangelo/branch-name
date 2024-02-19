## ['4.0.2'] - 2024-02-19

Changes

- Update gems.
- Explicitly add Gemfile groups.

## ['4.0.1'] - 2024-01-24

Changes

- Update gems.

## ['4.0.0'] - 2024-01-16

Changes

- Update min ruby version to 3.0.6.
- Update gems.

## ['3.10.10'] - 2024-01-16

Changes

- Update gems.

## ['3.10.9'] - 2024-01-07

Changes

- Relax ruby version requirements Gem::Requirement.new('>= 3.0.1', '< 4.0')
- Update gems.

## ['3.10.8'] - 2023-12-27

Changes

- Update gems.
- Update specs to work also on linux.

## ['3.10.7'] - 2023-12-02

Changes

- Update gems (missed one in previous version).

## ['3.10.6'] - 2023-12-02

Changes

- Update gems.

## ['3.10.5'] - 2023-11-03

Changes

- Various code refactors.
- Update gems.

## ['3.10.4'] - 2023-11-01

Changes

- Update gems.

## ['3.10.3'] - 2023-08-18

Changes

- Update gems.
- Various code refactors.
- Add some more test coverage.

## ['3.10.2'] - 2023-08-17

Changes

- Update gems.

## ['3.10.1'] - 2023-03-22

Changes

- Update gems. Remedy an activesupport dependabot alert.

## ['3.10.0'] - 2023-02-16

Changes

- Update gems.

## ['3.9.0'] - 2022-11-04

Changes

- Update gems.

## ['3.8.0'] - 2022-11-04

Changes

- Limit gem version to ~> 3.0 to avoid breaking changes.

## ['3.7.0'] - 2022-10-06

Changes

- Use thor_nested_subcommand to fix Thor nested subcommand help bug.
- Add missing global config option for create: :interactive.

## ['3.6.0'] - 2022-10-06

Changes

- Added a `-i` (interactive) option to `branch-name create`. When used in conjunction with the `-p` option (project creation), if the `-i` option is used, the user will be prompted to create the project. If the `-i` option is NOT used, the user will NOT be prompted when creating the project.
- Update the README.md file accordign to the aforementioned.

## ['3.5.1'] - 2022-10-05

Changes

- Add test coverage for the above scenarios.
- Use File.join to join paths and files safely where appropriate.
- Update .gemspec gem description with more detail.

Bug Fixes

- Fix bug that failed to remove underscore (_) characters in ticket and ticket descriptions from folder and branch name formulation.
- Fix bug that allowed unacceptable project folder token separators in the project folder name (-p option). The rule is now: for `branch-name create`, if the `options[:separator]` option (-s) is included in `Branch::Name::Normalizable::PROJECT_FOLDER_TOKEN_SEPARATORS`, `options[:separator]` (-s) will be used as the project folder token separator; otherwise, `Branch::Name::Normalizable::DEFAULT_PROJECT_FOLDER_TOKEN_SEPARATOR` will be used.

## ['3.5.0'] - 2022-10-04

Changes

- Fix broken link to CHANGELOG.md in .gemspec file.

## ['3.4.0'] - 2022-10-04

Changes

- `branch-name create` when creating projects prompts to confirm creating of projects by clicking 'y'. This change was prompted because projects were being created when users were attempting to display help for `branch-name create`; for example, users were incorrectly attempting to display help using `branch-name create help`, when, infact, `branch-name help create` should have been entered. Incorrectly executing `branch-name create help` would create a project with the name "help". Prompting the user to verify project creation solves this problem.
- Various changes in information printed to stdout when (for example) creating projects.

## ['3.3.0'] - 2022-09-27

Enhancements

- `branch-name config info` now displays the contents of both the Global and the local config files.

## ['3.2.2'] - 2022-09-27

Changes

- Refactor code that patches Thor incorrect display of nested commands (subcommangs).

## ['3.2.1'] - 2022-09-27

Changes

- Fix rubocop violations.
- Miscellaneous mixin refactors.
- Bug Fixes: Fix bug that displayed subcommand help incorrectly.

## ['3.1.0'] - 2022-09-26

Enhancements

- Branch names may now be created using a forward-slash (/). See the README.md file for more information.
- The `branch-name create :format_string` option string now accepts a %u placeholder which will be replaced with the currently logged in username. See `$ branch-name help create` for more information.

## ['3.0.0'] - 2022-09-26

Changes

- Default default commands to :help.
- Remove references to system for options, folder locations, etc. These were not being used and the nature of this tool is that global options should suffice.

Bug Fixes

- Not really a branch-name bug, but patched Thor bug that displays nested subcommands incorrectly.

## ['2.2.0'] - 2022-09-24

Enhancements

- Add support for `branch-name create` `-x` argument (see `branch-name help create`) which allows you to position the ticket and ticket description within the formulated branch name.
- The `branch-name create :project_location` option string now accepts any [`Time.strftime`](`https://apidock.com/ruby/Time/strftime`) format directive.
- Add better test coverage, although not what it should be (I'm working on it); this started a "quick and dirty" tool.
- `branch-name create` will now create the PROJECT_LOCATION if it does not exist.
- Update README.md file.

## ['2.1.0'] - 2022-09-22

Enhancements

- Add support for Windows clipboard. Branch names created are copied to the clibboard for macOS and Windows now.

## ['2.0.1-beta] - 2022-09-20

Bug fixes

- Ticket description was not joined properly (without token separator).
