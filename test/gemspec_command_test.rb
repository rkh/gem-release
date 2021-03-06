require File.expand_path('../test_helper', __FILE__)

require 'rubygems/commands/bootstrap_command'
require 'rubygems/commands/gemspec_command'

class GemspecCommandTest < MiniTest::Unit::TestCase
  def setup
    build_sandbox
    stub_command(GemspecCommand, :say)
    stub_command(BootstrapCommand, :say)
  end
  
  def teardown
    teardown_sandbox
  end
  
  test "gemspec_command" do
    GemspecCommand.new.invoke

    filename = 'foo-bar.gemspec'
    assert File.exists?(filename)

    BootstrapCommand.new.send(:write_version) # so it can be required by .gemspec
    assert_equal 'foo-bar', eval(File.read(filename)).name
  end
end