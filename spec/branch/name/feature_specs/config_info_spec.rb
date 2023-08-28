# frozen_string_literal: true

RSpec.describe 'branch-name config info', type: :feature do
  subject(:cli) { Branch::Name::CLI.start(%w[config info]) }

  context 'global config file' do
    context 'when the file exists' do
      before do
        with_global_config_file!
      end

      let(:expected_output) do
        /.*Global config file \(.*\.branch-name.*\) contents.*/m
      end

      it_behaves_like 'the correct output is displayed to stdout'
    end

    context 'when the file DOES NOT exists' do
      let(:expected_output) do
        /.*Global config file \(.*\.branch-name.*\) does not exist.*/m
      end

      it_behaves_like 'the correct output is displayed to stdout'
    end
  end

  context 'local config file' do
    context 'when the file exists' do
      before do
        with_local_config_file!
      end

      let(:expected_output) do
        /.*Local config file \(.*\.branch-name.*\) contents.*/m
      end

      it_behaves_like 'the correct output is displayed to stdout'
    end

    context 'when the file DOES NOT exists' do
      let(:expected_output) do
        /.*Local config file \(.*\.branch-name.*\) does not exist.*/m
      end

      it_behaves_like 'the correct output is displayed to stdout'
    end
  end

  context 'when the global folder is the same as the local folder' do
    before do
      with_global_config_file!
    end

    let(:dir_home) { dir_pwd }
    let(:expected_output) do
      /.*NOTE:.*Local and global configurations are the same.*/m
    end

    it_behaves_like 'the correct output is displayed to stdout'
  end
end
