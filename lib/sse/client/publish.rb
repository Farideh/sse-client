require 'json'

module Sse
  module Client
    class Client
      def publish(ochannel, timestamp, data)

        if self.configuration.redis_client
          channel=self.configuration.sse_namespace+":"+ochannel
          message=JSON.dump(data.merge!({_timestamp: timestamp}))

          self.configuration.redis_client.zadd(channel,timestamp,message)
          self.configuration.redis_client.zremrangebyrank(channel,0,-1*(self.configuration.max_queue_size+1))
          self.configuration.redis_client.publish(channel,message)
        else
          raise 
        end
      end
    end
  end
end