# frozen_string_literal: true

RSpec.shared_examples 'it formats the branch name properly' do
  it 'formats the branch name properly' do
    expect(subject).to eq branch_name
  end
end

RSpec.shared_examples 'the format_string is invalid' do
  it 'raises an error' do
    expected_error = /did not contain %t and %d format placeholders/
    expect { subject }.to raise_error(expected_error)
  end
end

RSpec.describe Branch::Name::Normalizable, type: :module do
  subject(:normalizable) do
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

  describe '#normalize_branch_name' do
    let(:branch_name) { 'TICKET_12345_Ticket_Description' }

    context 'with downcase option' do
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

    context 'with separator option' do
      let(:options) { default_options.merge({ separator: 'x' }) }
      let(:branch_name) { 'TICKETx12345xTicketxDescription' }

      it_behaves_like 'it formats the branch name properly'
    end

    context 'with format_string option' do
      let(:options) { default_options.merge({ format_string: '%d %t' }) }
      let(:branch_name) { 'Ticket_Description_TICKET_12345' }

      it_behaves_like 'it formats the branch name properly'

      context 'when the %t format placeholder is missing' do
        let(:options) { default_options.merge({ format_string: '%d' }) }
        let(:branch_name) { 'Ticket_Description' }

        it_behaves_like 'the format_string is invalid'
      end

      context 'when the %d format placeholder is missing' do
        let(:options) { default_options.merge({ format_string: '%t' }) }
        let(:branch_name) { 'TICKET_12345' }

        it_behaves_like 'the format_string is invalid'
      end

      context 'when the %t and %d format placeholders are missing' do
        let(:options) { default_options.merge({ format_string: '12345' }) }
        let(:branch_name) { 'Ticket_Description_TICKET_12345' }

        it_behaves_like 'the format_string is invalid'
      end
    end
  end
end
