# frozen_string_literal: true

RSpec.describe 'branch-name create', type: :feature do
  subject(:cli) { Branch::Name::CLI.start(args) }

  let(:args) { ['create', 'foo bar', '12345'] }

  context 'when no config files exist' do
    let(:expected_output) do
      if OS.mac? || OS.windows?
        /Branch name: "12345_foo_bar"\nBranch name "12345_foo_bar" has been copied to the clipboard!/
      else
        /Branch name: "12345_foo_bar"/
      end
    end

    it 'uses the defaut configuration to format the branch name' do
      expect { cli }.to output(/#{expected_output}/).to_stdout
    end
  end

  context 'when a global config file DOES NOT exists' do
    context 'when a local config file exists' do
      before do
        create_configuration.create_local_config_file! do |options|
          options['create']['separator'] = '-'
        end
      end

      let(:expected_output) do
        if OS.mac? || OS.windows?
          /Branch name: "12345-foo-bar"\nBranch name "12345-foo-bar" has been copied to the clipboard!/
        else
          /Branch name: "12345-foo-bar"/
        end
      end

      it 'uses the local configuration to format the branch name' do
        expect { cli }.to output(/#{expected_output}/).to_stdout
      end
    end
  end

  context 'when a local config file DOES NOT exist' do
    context 'when a global config file exists' do
      before do
        create_configuration.create_global_config_file! do |options|
          options['create']['format_string'] = '%d %t'
          options['create']['separator'] = '_'
        end
      end

      let(:expected_output) do
        if OS.mac? || OS.windows?
          /Branch name: "foo_bar_12345"\nBranch name "foo_bar_12345" has been copied to the clipboard!/
        else
          /Branch name: "foo_bar_12345"/
        end
      end

      it 'uses the global configuration to format the branch name' do
        expect { cli }.to output(/#{expected_output}/).to_stdout
      end
    end
  end

  context 'when local and global config files exist' do
    context 'when creating a branch name in folder with a local config file' do
      before do
        create_configuration.create_global_config_file!

        create_configuration.create_local_config_file! do |options|
          options['create']['format_string'] = '%d %t'
          options['create']['separator'] = '_'
        end
      end

      let(:expected_output) do
        if OS.mac? || OS.windows?
          /Branch name: "foo_bar_12345"\nBranch name "foo_bar_12345" has been copied to the clipboard!/
        else
          /Branch name: "foo_bar_12345"/
        end
      end

      it 'uses the local config file to format the branch name' do
        expect { cli }.to output(/#{expected_output}/).to_stdout
      end
    end
  end
end
