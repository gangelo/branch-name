# frozen_string_literal: true

PROJECT_FOLDER_TOKEN_SEPARATORS = Branch::Name::Normalizable::PROJECT_FOLDER_TOKEN_SEPARATORS
DEFAULT_PROJECT_FOLDER_TOKEN_SEPARATOR = Branch::Name::Normalizable::DEFAULT_PROJECT_FOLDER_TOKEN_SEPARATOR

RSpec.describe Branch::Name::Normalizable, type: :module do
  subject(:normalized_branch_name) do
    Class.new do
      include Branch::Name::Normalizable

      attr_reader :options

      def initialize(options)
        @options = Thor::CoreExt::HashWithIndifferentAccess.new(options)
      end

      def current_command_chain
        [:some_command]
      end
    end.new(options).normalize_branch_name(ticket_description, ticket)
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
  let(:ticket) { 'TICKET-12345' }
  let(:ticket_description) { 'Ticket Description' }
  let(:temp_directory) { Dir.tmpdir }

  shared_examples 'it formats the branch name properly' do
    it 'formats the branch name properly' do
      expect(subject).to eq branch_name
    end
  end

  shared_examples 'it formats the folder name properly' do
    it 'formats the folder name properly' do
      expect(subject).to eq folder_name
    end
  end

  shared_examples 'the format_string (-x) is invalid' do
    it 'raises an error' do
      expected_error = /did not contain %t and %d format placeholders/
      expect { subject }.to raise_error(expected_error)
    end
  end

  describe '#normalize_branch_name' do
    let(:branch_name) { 'TICKET_12345_Ticket_Description' }

    context 'with downcase (-d) option' do
      context 'when false' do
        let(:options) { default_options }

        it 'formulates a branch name that is lowercase' do
          expect(subject).to eq branch_name
        end
      end

      context 'when true' do
        let(:options) { default_options.merge({ downcase: true }) }

        it 'formulates a branch name that is lowercase' do
          expect(subject).to eq branch_name.downcase
        end
      end
    end

    context 'with separator (-s) option' do
      context 'when the separator is a dash (-)' do
        let(:options) { default_options.merge({ separator: '-' }) }
        let(:branch_name) { 'TICKET-NO-12345-Dash-and-Underscore-Ticket-Description' }

        context 'when the ticket and description have both dashes (-) and underscores (_)' do
          let(:ticket) { 'TICKET-NO_12345' }
          let(:ticket_description) { 'Dash-and_Underscore Ticket_Description' }

          it_behaves_like 'it formats the branch name properly'
        end
      end

      context 'when the separator is an underscore (_)' do
        let(:options) { default_options.merge({ separator: '_' }) }
        let(:branch_name) { 'TICKET_NO_12345_Dash_and_Underscore_Ticket_Description' }

        context 'when the ticket and description have both dashes (-) and underscores (_)' do
          let(:ticket) { 'TICKET-NO_12345' }
          let(:ticket_description) { 'Dash-and_Underscore Ticket_Description' }

          it_behaves_like 'it formats the branch name properly'
        end
      end

      context 'when the separator is a randon character (x)' do
        let(:options) { default_options.merge({ separator: 'x' }) }
        let(:branch_name) { 'TICKETx12345xTicketxDescription' }

        it_behaves_like 'it formats the branch name properly'
      end
    end

    context 'with format string (-x) option' do
      let(:options) { default_options.merge({ format_string: '%d %t' }) }
      let(:branch_name) { 'Ticket_Description_TICKET_12345' }

      it_behaves_like 'it formats the branch name properly'

      context 'when the %t format placeholder is missing' do
        let(:options) { default_options.merge({ format_string: '%d' }) }
        let(:branch_name) { 'Ticket_Description' }

        it_behaves_like 'the format_string (-x) is invalid'
      end

      context 'when the %d format placeholder is missing' do
        let(:options) { default_options.merge({ format_string: '%t' }) }
        let(:branch_name) { 'TICKET_12345' }

        it_behaves_like 'the format_string (-x) is invalid'
      end

      context 'when the %t and %d format placeholders are missing' do
        let(:options) { default_options.merge({ format_string: '12345' }) }
        let(:branch_name) { 'Ticket_Description_TICKET_12345' }

        it_behaves_like 'the format_string (-x) is invalid'
      end
    end
  end

  describe '#project_folder_name_from' do
    subject(:project_folder_name) do
      Class.new do
        include Branch::Name::Normalizable

        attr_reader :options

        def initialize(options)
          @options = Thor::CoreExt::HashWithIndifferentAccess.new(options)
        end

        def current_command_chain
          [:some_command]
        end
      end.new(options).project_folder_name_from(normalized_branch_name)
    end

    it do
      # Sanity check; make sure we account for all separators in our
      # below tests.
      expect(PROJECT_FOLDER_TOKEN_SEPARATORS).to eq %w[- _]
    end

    context 'when the separator (-s) is included in Normalizable::PROJECT_FOLDER_TOKEN_SEPARATORS' do
      context 'when an underscore (_)' do
        let(:options) { default_options.merge({ separator: '_' }) }
        let(:folder_name) { 'TICKET_12345_Ticket_Description' }

        it_behaves_like 'it formats the folder name properly'
      end

      context 'when a dash ()' do
        let(:options) { default_options.merge({ separator: '-' }) }
        let(:folder_name) { 'TICKET-12345-Ticket-Description' }

        it_behaves_like 'it formats the folder name properly'
      end
    end

    context 'when the separator (-s) is NOT included in Normalizable::PROJECT_FOLDER_TOKEN_SEPARATORS' do
      let(:options) { default_options.merge({ separator: DEFAULT_PROJECT_FOLDER_TOKEN_SEPARATOR }) }
      let(:folder_name) do
        'TICKET#12345#Ticket#Description'.gsub('#', DEFAULT_PROJECT_FOLDER_TOKEN_SEPARATOR)
      end

      it_behaves_like 'it formats the folder name properly'
    end
  end
end
