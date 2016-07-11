require_relative '../spec_helper'

shared_examples_for 'a Ruby image' do
  it 'includes the generic Ruby command' do
    expect(capture_command_in_container("ruby #{jruby_dev_arg} -v")).to match(/ruby/)
  end

  it 'includes Node.js' do
    expect { capture_command_in_container('node -v') }.not_to raise_error
  end

  it 'includes RubyGems' do
    expect { capture_command_in_container('gem -v') }.not_to raise_error
  end

  it 'includes Bundler' do
    expect(capture_command_in_container('bundle -v')).to match(/Bundler/)
  end

  it 'includes Rake' do
    expect(capture_command_in_container('rake -V')).to match(/rake/)
  end
end

shared_examples_for 'a Ruby image containing JRuby' do
  it 'includes the generic JRuby command' do
    expect(capture_command_in_container('jruby --dev -v')).to match(/jruby/)
  end
end
