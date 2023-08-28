# frozen_string_literal: true

RSpec.describe Branch::Name::Locatable do
  subject(:locatable) { described_class }

  describe '.global_folder?' do
    context 'when the global folder is the same as the local folder' do
      before do
        allow(locatable).to receive(:global_folder)
          .and_return(locatable.local_folder)
      end

      it 'returns true' do
        expect(locatable.global_folder?).to be true
      end
    end

    context 'when the global folder is not the same as the local folder' do
      it 'returns true' do
        expect(locatable.global_folder?).to be false
      end
    end
  end
end
