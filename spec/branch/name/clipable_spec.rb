# frozen_string_literal: true

RSpec.describe Branch::Name::Clipable, type: :module do
  before do
    allow(OS).to receive(:mac?).and_return false
    allow(OS).to receive(:windows?).and_return false
  end

  describe '.copy_to_clipboard' do
    context 'when macOS' do
      before do
        allow(OS).to receive(:mac?).and_return true
        allow(described_class).to receive(:copy_to_clipboard_macos).and_return true
      end

      after do
        described_class.copy_to_clipboard('text')
      end

      it 'calls copy_to_clipboard_macos' do
        expect(described_class).to receive(:copy_to_clipboard_macos).once
      end
    end

    context 'when windows' do
      before do
        allow(OS).to receive(:windows?).and_return true
        allow(described_class).to receive(:copy_to_clipboard_windows).and_return true
      end

      after do
        described_class.copy_to_clipboard('text')
      end

      it 'calls copy_to_clipboard_windows' do
        expect(described_class).to receive(:copy_to_clipboard_windows).once
      end
    end
  end
end
