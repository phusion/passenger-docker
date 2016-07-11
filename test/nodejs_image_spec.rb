require_relative 'spec_helper'
require_relative 'shared/base_system_spec'
require_relative 'shared/nodejs_image_spec'

RSpec.describe 'passenger-nodejs image' do
  before(:all) do
    @container_id = capture_command(
      "docker run -d phusion/passenger-nodejs:#{VERSION} sleep 99999").strip
  end

  after(:all) do
    run("docker rm -f #{@container_id} >/dev/null")
  end

  let(:jruby_dev_arg) { nil }

  include_examples 'a base system'
  include_examples 'a Node.js image'
end
