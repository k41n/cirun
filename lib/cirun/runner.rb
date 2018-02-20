module Cirun
  class Runner
    def initialize(opts)
      @opts = opts
    end

    def run
      ruby_short = @opts.ruby.split('-').first
      cmd = "docker run --env RUBY_VERSION=ruby-#{ruby_short} --env DB=#{@opts.database} --env REDMINE=redmine-#{@opts.redmine} --env PLUGIN=#{@opts.plugin} --env DEPENDENT=#{@opts.dependent} --env CODEPATH=/plugin --mount type=bind,source=#{`pwd`.chomp},target=/var/www/ruby-#{ruby_short}/#{@opts.database}/redmine-#{@opts.redmine}/plugins/#{@opts.plugin} redmineup/#{@opts.plugin} /root/run_local.sh"
      puts "Running:\n#{cmd}"
      %x[ #{cmd} ]
    end
  end
end
