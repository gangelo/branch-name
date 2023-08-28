# frozen_string_literal: true

shared_examples 'the correct output is displayed to stdout' do
  it 'displays the correct output' do
    expect { cli }.to output(/#{expected_output}/).to_stdout
  end
end
