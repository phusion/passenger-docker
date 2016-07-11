require_relative 'spec_helper'
require_relative 'shared/base_system_spec'
require_relative 'shared/ruby_image_spec'
require_relative 'shared/nodejs_image_spec'

RSpec.describe 'passenger-full image' do
  before(:all) do
    @container_id = capture_command(
      "docker run -d phusion/passenger-full:#{VERSION} sleep 99999").strip
  end

  after(:all) do
    run("docker rm -f #{@container_id} >/dev/null")
  end

  let(:jruby_dev_arg) { nil }

  include_examples 'a base system'
  include_examples 'a Ruby image'
  include_examples 'a Ruby image containing JRuby'
  include_examples 'a Node.js image'

  supported_rubies.each do |ruby_spec|
    context "#{ruby_spec[:rvm_id]} support" do
      let(:ruby_spec) { ruby_spec }

      it 'includes this Ruby' do
        ruby_command = "rvm-exec #{ruby_spec[:rvm_id]} ruby #{jruby_dev_arg} -v"
        expect(capture_command_in_container(ruby_command)).to \
          match(/^#{Regexp.escape ruby_spec[:engine]}
            [[:blank:]]
            #{Regexp.escape ruby_spec[:major_minor_version]}[\. ]/x)
      end

      it "includes the #{ruby_spec[:engine]}#{ruby_spec[:major_minor_version]} wrapper script" do
        ruby_command = "#{ruby_spec[:engine]}#{ruby_spec[:major_minor_version]} #{jruby_dev_arg} -v"
        expect(capture_command_in_container(ruby_command)).to \
          match(/^#{Regexp.escape ruby_spec[:engine]}
            [[:blank:]]
            #{Regexp.escape ruby_spec[:major_minor_version]}[\. ]/x)
      end
    end
  end
end
