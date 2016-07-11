require_relative '../spec_helper'

shared_examples_for 'a Node.js image' do
  it 'includes Node.js' do
    expect { capture_command_in_container('node -v') }.not_to raise_error
  end

  it 'includes NPM' do
    expect { capture_command_in_container('npm -v') }.not_to raise_error
  end
end
