RSpec.shared_context 'test objects' do
  subject(:test_object) do
    class TestObject
      include Branch::Name::Clipable
      include Branch::Name::Configurable
      include Branch::Name::Exitable
      include Branch::Name::Loadable
      include Branch::Name::Locatable
      include Branch::Name::Normalizable
      include Branch::Name::Projectable
    end
    TestObject.new
  end
end

RSpec.configure do |config|
  config.include_context 'test objects'
end
