require 'connection_pool'
module Sse
  module Client
    class Client
      class Configuration
        attr_accessor \
          :redis_options,
          :sse_namespace,
          :max_queue_size

        def initialize
          @redis_options = {}
          @sse_namespace = 'such_naymspes'
          @max_queue_size=1000
          @connection_pool_size=5
          @redis_pool_instance=nil
        end

        def redis_pool
          if @redis_pool_instance.nil?
            @redis_pool_instance=ConnectionPool.new(size: @connection_pool_size, timeout: 5){ 
              Redis.new(@redis_options)
            }
          end
          return @redis_pool_instance
        end

      end

      attr_accessor :configuration

      def configure
        self.configuration ||= Configuration.new
        yield(configuration)
      end

    end
  end
end
