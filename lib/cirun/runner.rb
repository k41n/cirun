module Cirun
  class Runner
    def initialize(opts)
      @opts = opts
    end

    def run
      cmd = "docker run -t -i --env RUBY=#{@opts.ruby} --env DB=#{@opts.db} --env REDMINE=#{@opts.redmine} --env PLUGIN=#{@opts.plugin} --env DEPENDENT=#{@opts.dependent} --env CODEPATH=#{`pwd`.chomp} redmineup/#{@opts.plugin} /root/run_for.sh"
      puts "Running:\n#{cmd}"
      %x[ #{cmd} ]
    end
  end
end
