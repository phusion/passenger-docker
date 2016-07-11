require_relative '../spec_helper'

shared_examples_for 'a base system' do
  it 'includes Passenger' do
    expect(capture_command_in_container('passenger -v')).to match(/Phusion Passenger/)
  end

  it 'includes Nginx' do
    expect(capture_command_in_container('nginx -v')).to match(/nginx version/)
  end

  specify 'passenger_system_ruby works' do
    expect(capture_command_in_container("passenger_system_ruby #{jruby_dev_arg} -v")).to match(/ruby/)
  end

  specify 'passenger_free_ruby works' do
    expect(capture_command_in_container("passenger_free_ruby #{jruby_dev_arg} -v")).to match(/ruby/)
  end

  specify 'passenger-config validate-install succeeds' do
    expect(test_command_in_container('passenger-config validate-install --auto')).to be_truthy
  end
end
