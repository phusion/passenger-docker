require_relative 'spec_helper'
require_relative 'shared/base_system_spec'
require_relative 'shared/ruby_image_spec'

supported_rubies.each do |ruby_spec|
  RSpec.describe("#{ruby_spec[:docker_image_id]} image") do
    before(:all) do
      @container_id = capture_command(
        "docker run -d #{ruby_spec[:docker_image_name]}:#{VERSION} sleep 99999").strip
    end

    after(:all) do
      run("docker rm -f #{@container_id} >/dev/null")
    end

    let(:ruby_spec) { ruby_spec }

    def jruby_dev_arg
      if ruby_spec[:rvm_id] =~ /jruby/
        '--dev'
      else
        nil
      end
    end

    include_examples 'a base system'
    include_examples 'a Ruby image'
    if ruby_spec[:rvm_id] =~ /jruby/
      include_examples 'a Ruby image containing JRuby'
    end

    it 'includes the version-specific Ruby command' do
      version_specific_cmd = "rvm-exec #{ruby_spec[:rvm_id]} ruby #{jruby_dev_arg} -v"
      about_regex =
        /^#{Regexp.escape ruby_spec[:engine]}
          [[:blank:]]
          #{Regexp.escape ruby_spec[:major_minor_version]}[\. ]/x

      expect(capture_command_in_container(version_specific_cmd)).to \
        match(about_regex)
    end

    it 'includes exactly one Ruby' do
      rubies = capture_command_in_container('/usr/local/rvm/bin/rvm list strings').split("\n")
      expect(rubies.size).to eq(1)
    end

    it 'is included in the Makefile' do
      makefile = File.read("#{ROOT}/Makefile")
      # Ignore everything before the 'all' target
      makefile.sub!(/.*?^all:/m, '')

      reference_ruby_spec = supported_rubies.first
      reference_lines = makefile.split("\n").grep(/#{Regexp.escape(reference_ruby_spec[:makefile_id])}/)
      reference_lines.each do |reference_line|
        supported_rubies.each do |test_ruby_spec|
          expected_line = reference_line.
            gsub(reference_ruby_spec[:docker_image_name],
              test_ruby_spec[:docker_image_name]).
            gsub(reference_ruby_spec[:makefile_id],
              test_ruby_spec[:makefile_id])
          if makefile !~ /^#{Regexp.escape(expected_line)}$/
            fail "Expected the Makefile to include this line: #{expected_line}"
          end
        end
      end
    end

    specify 'the generic Ruby command executes the version-specific Ruby' do
      version_specific_cmd = "rvm-exec #{ruby_spec[:rvm_id]} ruby #{jruby_dev_arg} -v"
      expect(capture_command_in_container(version_specific_cmd)).to eq(
        capture_command_in_container("ruby #{jruby_dev_arg} -v"))
    end
  end
end
