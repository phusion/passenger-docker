require_relative 'spec_helper'
require_relative 'shared/base_system_spec'
require_relative 'shared/ruby_image_spec'

RSpec.describe 'passenger-customizable image' do
  before(:all) do
    @container_id = capture_command(
      "docker run -d phusion/passenger-customizable:#{VERSION} sleep 99999").strip
  end

  after(:all) do
    run("docker rm -f #{@container_id} >/dev/null")
  end

  let(:jruby_dev_arg) { nil }

  include_examples 'a base system'

  it "includes #{latest_mri_spec[:rvm_id]} as the default Ruby" do
    about_regex =
      /^#{Regexp.escape latest_mri_spec[:engine]}
        [[:blank:]]
        #{Regexp.escape latest_mri_spec[:version]} /x
    expect(capture_command_in_container('ruby -v')).to match(about_regex)
  end

  specify "#{latest_mri_spec[:rvm_id]} is installed through RVM" do
    expect(capture_command_in_container('dpkg-query -S /usr/bin/ruby || true')).to match(/no path found/)
    expect(test_command_in_container('grep "exec /usr/local/rvm" /usr/bin/ruby')).to be_truthy
    expect(test_command_in_container('dpkg-query -L ruby-fake')).to be_truthy
  end

  it 'includes exactly one Ruby' do
    rubies = capture_command_in_container('/usr/local/rvm/bin/rvm list strings').split("\n")
    expect(rubies.size).to eq(1)
  end

  it 'does not include Node.js' do
    expect(test_command_in_container('which node')).to be_falsey
  end
end
