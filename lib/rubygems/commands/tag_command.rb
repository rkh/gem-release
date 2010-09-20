require 'gem_release/helpers'

class Gem::Commands::TagCommand < Gem::Command
  include GemRelease
  include Helpers, CommandOptions

  OPTIONS = { :commit => false, :format => 'v%s' }

  attr_reader :arguments, :usage

  def initialize
    super 'tag', 'Create a git tag and push --tags to origin'
    option :format, '-m', 'Tag name/message format (%s will be replaced with version)'
    option :commit, '-c', 'Creat a (potentially empty) commit before tagging'
  end

  def execute
    commit if options[:commit]
    tag
    push
  end
  
  protected
    def commit
      say "Creating empty commit"
      `git commit --allow-empty -m "Release #{tag_name}"`
    end

    def tag
      say "Creating git tag #{tag_name}"
      `git tag -am 'tag #{tag_name}' #{tag_name}`
    end

    def push
      say "Pushing --tags to origin git repository"
      `git push --tags origin`
    end
    
    def tag_name
      (options[:format] || OPTIONS[:format]) % gem_version
    end
end