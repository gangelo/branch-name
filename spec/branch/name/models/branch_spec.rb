# frozen_string_literal: true

RSpec.describe Branch::Name::Models::Branch, type: :model do
  subject(:branch_name) do
    described_class.new(description: description,
                        ticket: ticket,
                        options: options)
  end

  let(:description) { 'a description' }
  let(:ticket) { nil }
  let(:options) { {} }

  describe 'validations' do
    it { should validate_presence_of(:description) }
  end
end
