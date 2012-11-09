require "better_counters/version"

module BetterCounters
  extend ActiveSupport::Concern

  def update_cache_counters(p = {}, n = 1)
    p.each do |c|
      if c[1]
        column = (c[1] == true) ? self.class.table_name + "_count" : c[1]
        n > 0 ? send(c[0]).increment(column, 1) : send(c[0]).decrement(column, 1)
        send(c[0]).save
      end
    end
  end

  module ClassMethods
    def counter_cache(p)
      after_create  Proc.new { update_cache_counters(p, 1) }
      after_destroy Proc.new { update_cache_counters(p, -1) }
    end
  end
end

ActiveRecord::Base.send(:include, BetterCounters)