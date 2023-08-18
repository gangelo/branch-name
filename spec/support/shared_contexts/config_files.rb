# frozen_string_literal: true

RSpec.shared_context 'with config files' do
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
end

RSpec.configure do |config|
  config.include_context 'with config files'
end
