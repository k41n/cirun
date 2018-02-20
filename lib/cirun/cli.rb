require 'rubygems'
require 'optparse'
require 'ostruct'

require_relative './variants'

module Cirun
  class CLI
    def initialize
      @options = OpenStruct.new
      @options.database  = ''
      @options.redmine   = ''
      @options.ruby      = ''
      @options.plugin    = ''
      @options.dependent = ''
    end

    def parse
      OptionParser.new do |opts|
        opts.banner = 'Usage: cirun [options]'
        opts.on('-d', '--database DATABASE', "Specify database #{database_list}") do |db|
          @options.database = db
        end
        opts.on('-m', '--redmine REDMINE', "Specify redmine #{redmine_list}") do |redmine|
          @options.redmine = redmine
        end
        opts.on('-r', '--ruby RUBY', "Specify ruby #{ruby_list}") do |ruby|
          @options.ruby = ruby
        end
        opts.on('-p', '--plugin PLUGIN', "Specify plugin (will try to guess from pwd)") do |plugin|
          @options.plugin = plugin
        end
        opts.on('-e', '--dependent DEPENDENT', "Specify plugin dependency") do |dependent|
          @options.dependent = dependent
        end
      end.parse!

      validate_options || abort_due_to_lack_of_options
      enhance_options
      @options
    end

    private

    def validate_options
      validate_database &&
        validate_ruby &&
        validate_redmine
    end

    def validate_database
      @options.database.size > 0 && Cirun::Variants::DATABASES.include?(@options.database)
    end

    def validate_ruby
      @options.ruby.size > 0 && Cirun::Variants::RUBIES.include?(@options.ruby)
    end

    def validate_redmine
      @options.redmine.size > 0 && Cirun::Variants::REDMINES.include?(@options.redmine)
    end

    def abort_due_to_lack_of_options
      puts "Database should be given and be one of #{database_list}" unless validate_database
      puts "Ruby should be given and be one of #{ruby_list}" unless validate_ruby
      puts "Redmine should be given and be one of #{redmine_list}" unless validate_redmine
      exit -1
    end

    def enhance_options
      return if @options.plugin.size > 0
      @options.plugin = Dir.pwd.split('/').last
    end

    def database_list
      Cirun::Variants::DATABASES.join('|')
    end

    def redmine_list
      Cirun::Variants::REDMINES.join('|')
    end

    def ruby_list
      Cirun::Variants::RUBIES.join('|')
    end
  end
end
