## ['2.2.0'] - 2022-09-24
* Enhancements:
  * Add support for `branch-name create` `-x` argument (see `branch-name help create`) which allows you to position the ticket and ticket description within the forulated branch name.
  * The `branch-name create :project_location` option string now accepts any [`Time.strftime`](`https://apidock.com/ruby/Time/strftime`) format directive.
  * Add better test coverage, although not what it should be (I'm working on it); this started a "quick and dirty" tool.
  * `branch-name create` will now create the PROJECT_LOCATION if it does not exist.
  * Update README.md file.

## ['2.1.0'] - 2022-09-22
* Enhancements: Add support for Windows clipboard. Branch names created are copied to the clibboard for macOS and Windows now.

## ['2.0.1-beta] - 2022-09-20
* Bug fixes: ticket description was not joined properly (without token separator).
