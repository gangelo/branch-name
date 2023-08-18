# frozen_string_literal: true

RSpec.describe 'branch-name config info', type: :feature do
  subject(:cli) { Branch::Name::CLI.start(%w[config info]) }

  shared_examples 'the correct output is displayed to stdout' do
    it 'displays the correct output' do
      expect { cli }.to output(/#{expected_output}/).to_stdout
    end
  end

  before do
    allow(Dir).to receive(:home).and_return(dir_home)
    allow(Dir).to receive(:pwd).and_return(dir_pwd)
    FileUtils.mkdir_p(dir_home)
    FileUtils.mkdir_p(dir_pwd)
  end

  after do
    FileUtils.rm_rf(dir_home)
    FileUtils.rm_rf(dir_pwd)
  end

  let(:dir_home) { File.join(Dir.tmpdir, 'home') }
  let(:dir_pwd) { File.join(Dir.tmpdir, 'pwd') }

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

  def with_global_config_file!
    Branch::Name::CLI.start(%w[config init global])
  end

  def with_local_config_file!
    Branch::Name::CLI.start(%w[config init local])
  end
end
