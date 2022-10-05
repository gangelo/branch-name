RSpec.shared_examples 'it formats the folder name properly' do
  it 'formats the folder name properly' do
    actual_folder_name = subject.project_folder_for branch_name
    puts actual_folder_name
    expect(actual_folder_name).to eq expected_folder_name
  end
end

PROJECT_FOLDER_TOKEN_SEPARATORS = Branch::Name::Normalizable::PROJECT_FOLDER_TOKEN_SEPARATORS
DEFAULT_PROJECT_FOLDER_TOKEN_SEPARATOR =  Branch::Name::Normalizable::DEFAULT_PROJECT_FOLDER_TOKEN_SEPARATOR

RSpec.describe Branch::Name::Projectable, type: :module do
  subject(:projectable) do
    Class.new do
      include Branch::Name::Projectable

      attr_reader :options

      def initialize(options)
        @options = Thor::CoreExt::HashWithIndifferentAccess.new(options)
      end

      def current_command_chain
        [:some_command]
      end
    end.new(options)
  end

  let(:default_options) do
    {
      downcase: false,
      separator: '_',
      format_string: '%t %d',
      project: false,
      project_location: temp_directory.to_s,
      project_files: %w[readme.txt scratch.rb snippets.rb]
    }
  end
  let(:options) { default_options }
  let(:expected_folder_name) do
    File.join(temp_directory, branch_name)
  end
  let(:temp_directory) { Dir.tmpdir }

  describe '#project_folder_for' do
    context 'when the separator (-s) is included in Normalizable::PROJECT_FOLDER_TOKEN_SEPARATORS' do
      context 'when an underscore (_)' do
        let(:options) { default_options.merge({ separator: '_' }) }
        let(:branch_name) { 'TICKET_12345_Ticket_Description' }

        it_behaves_like 'it formats the folder name properly'
      end

      context 'when a dash ()' do
        let(:options) { default_options.merge({ separator: '-' }) }
        let(:branch_name) { 'TICKET-12345-Ticket-Description' }

        it_behaves_like 'it formats the folder name properly'
      end
    end

    context 'when the separator (-s) is NOT included in Normalizable::PROJECT_FOLDER_TOKEN_SEPARATORS' do
      let(:options) { default_options.merge({ separator: DEFAULT_PROJECT_FOLDER_TOKEN_SEPARATOR }) }
      let(:branch_name) do
        'TICKET#12345#Ticket#Description'.gsub('#', DEFAULT_PROJECT_FOLDER_TOKEN_SEPARATOR)
      end

      it_behaves_like 'it formats the folder name properly'
    end
  end
end
