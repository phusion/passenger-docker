require 'shellwords'

ROOT = File.absolute_path(File.dirname(File.dirname(__FILE__)))
VERSION = begin
  File.read("#{ROOT}/Makefile") =~ /VERSION = (.+)/
  $1
end

def supported_rubies
  $supported_rubies ||= begin
    paths = Dir["#{ROOT}/image/*ruby-*.sh"].grep(/\d/)
    result = paths.map do |path|
      rvm_id = File.basename(path, '.sh')
      ruby_engine, ruby_version = rvm_id.split('-', 2)
      major_minor_version = ruby_version.split('.')[0..1].join('.')
      makefile_id = docker_id = "#{ruby_engine}#{major_minor_version.gsub('.', '')}"
      {
        rvm_id: rvm_id,
        engine: ruby_engine,
        version: ruby_version,
        major_minor_version: major_minor_version,
        makefile_target: "build_#{makefile_id}",
        makefile_id: makefile_id,
        docker_image_id: docker_id,
        docker_image_name: "phusion/passenger-#{docker_id}"
      }
    end
  end
end

def latest_mri_spec
  $latest_mri_spec ||= begin
    result = nil

    supported_rubies.each do |ruby_spec|
      next if ruby_spec[:engine] != 'ruby'
      if result.nil? || compare_ruby_spec_version(ruby_spec, result) > 0
        result = ruby_spec
      end
    end

    result
  end
end

def compare_ruby_spec_version(a, b)
  a_version = a[:version].split('.').map { |x| x.to_i }
  b_version = b[:version].split('.').map { |x| x.to_i }
  a_version <=> b_version
end

module TestUtils
  def run(command)
    if !system(command)
      fail "Command failed: #{command}"
    end
  end

  def capture_command(command)
    output = `#{command} 2>&1`
    if $?.nil? || !$?.success?
      fail "Command failed: #{command}\n" \
        "Output:\n" \
        "#{output}"
    else
      output
    end
  end

  def capture_command_in_container(command)
    if @container_id.nil?
      raise "No container ID set"
    else
      real_command = "bash -c #{Shellwords.escape(command)}"
      capture_command("docker exec #{@container_id} #{real_command}")
    end
  end

  def test_command_in_container(command)
    if @container_id.nil?
      raise "No container ID set"
    else
      output = capture_command_in_container("#{command}; CODE=$?; echo; echo $CODE")
      output.split("\n").last == '0'
    end
  end
end

RSpec.configure do |config|
  config.include TestUtils
end
