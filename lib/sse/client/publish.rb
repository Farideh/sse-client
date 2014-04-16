require 'json'

module Sse
  module Client
    class Client
      def publish(ochannel, timestamp, data)

        self.configuration.redis_pool.with do |redis|
          channel=self.configuration.sse_namespace+":"+ochannel
          message=JSON.dump(data.merge!({_timestamp: timestamp}))
          redis.multi do 
            redis.zadd(channel,timestamp,message)
            redis.zremrangebyrank(channel,0,-1*(self.configuration.max_queue_size+1))
            redis.publish(channel,message)
          end
        end
      end
    end
  end
end