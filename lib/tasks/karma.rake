require 'benchmark'

namespace :karma do
  desc "Update the karma cache for all users"
  task :update_all_users => :environment do
    time = Benchmark.measure do
      User.limit(100000).each do |user|
        user.populate_total_karma
      end
    end

    puts time
  end
end
