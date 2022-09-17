# frozen_string_literal: true

RSpec.describe Branch::Name do
  it 'has a version number' do
    expect(Branch::Name::VERSION).not_to be_nil
  end
end
