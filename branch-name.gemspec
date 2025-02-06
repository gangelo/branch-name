# frozen_string_literal: true

require_relative 'lib/branch/name/version'

Gem::Specification.new do |spec|
  spec.name         = 'branch-name'
  spec.version      = Branch::Name::VERSION
  spec.authors      = ['Gene M. Angelo, Jr.']
  spec.email        = ['public.gma@gmail.com']

  spec.summary      = 'Generates a branch name based on a JIRA ticket/ticket number.'
  spec.description  = <<-DESC
  branch-name is a gem that provides a command-line interface that allows you to accomplish several tasks, tasks I personally find myself having to carry out every time I work on a feature branch. I created this gem for myself; however, you are free to use it yourself, if any of these tasks fits into your personal routine:

  1. Formulate a git feature branch name, given a jira ticket and jira ticket description. Why? Because I am constantly having to create git feature branch names that are based on jira ticket and jira ticket descriptions.
  2. Optionally create a "project" based on the branch name (formulated in step 1 above). Why? Because I'm constantly having to create folders to manage files associated with the feature branches I am working on.
  3. Optionally use and manage default options that determine the git feature branch name formulated, project greated, and default files associated with the project.Why? Because I routinely have to create files to support the feature I am working on and associate them with the feature I am working on. For example: scratch.rb to hold scratch code, snippets.rb to hold code to execute to perform redundant tasks, and readme.txt files to document things I need to remember.
  DESC
  spec.homepage     = 'https://github.com/gangelo/branch-name'
  spec.license      = 'MIT'

  spec.required_ruby_version = Gem::Requirement.new('>= 3.0.6', '< 4.0')

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/gangelo/branch-name'
  spec.metadata['changelog_uri'] = 'https://github.com/gangelo/branch-name/blob/main/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '~> 8.0', '>= 8.0.1'
  spec.add_dependency 'colorize', '>= 1.1.0', '< 2.0'
  spec.add_dependency 'os', '>= 1.1', '< 2.0'
  spec.add_dependency 'ostruct', '~> 0.6.1'
  spec.add_dependency 'reline', '~> 0.6.0'
  spec.add_dependency 'thor', '>= 1.2', '< 2.0'
  spec.add_dependency 'thor_nested_subcommand', '>= 1.0', '< 2.0'

  # Remove this for now.
  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.post_install_message = <<~POST_INSTALL
    Thank you for installing branch-name!

    Run `branch-name` from your command line to get started.

    View the dsu README.md here: https://github.com/gangelo/branch-name
    View the dsu CHANGELOG.md: https://github.com/gangelo/branch-name/blob/main/CHANGELOG.md

                *
               ***
             *******
            *********
     ***********************
        *****************
          *************
         ******* *******
        *****       *****
       ***             ***
      **                 **

    Using branch-name? branch-name is made available free of charge. Please consider giving branch-name a STAR on GitHub as well as sharing branch-name with your fellow developers on social media.

    Knowing that branch-name is being used and appreciated is a great motivator to continue developing and improving branch-name.

    >>> Star it on github: https://github.com/gangelo/branch-name
    >>> Share on social media: https://rubygems.org/gems/branch-name

    Thank you!

    <3 Gene
  POST_INSTALL
end
