require File.expand_path('../test_helper', __FILE__)

require 'rubygems/commands/tag_command'

class TagCommandTest < MiniTest::Unit::TestCase
  include Gem::Commands
  
  def setup
    stub_command(TagCommand, :say)
  end

  test "tag_command" do
    command = TagCommand.new
    command.stubs(:gem_version).returns('1.0.0')
    command.expects(:`).with("git tag -am 'tag v1.0.0' v1.0.0")
    command.expects(:`).with("git push --tags origin")
    command.invoke
  end

  test "tag_command supports custom formats" do
    command = TagCommand.new
    command.stubs(:gem_version).returns('1.0.0')
    command.expects(:`).with("git tag -am 'tag 1.0.0' 1.0.0")
    command.expects(:`).with("git push --tags origin")
    command.invoke("--format=%s")
  end
end