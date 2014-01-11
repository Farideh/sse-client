module Sse
  module Client
    class Client
      class Configuration
        attr_accessor \
          :redis_client,
          :sse_namespace,
          :max_queue_size

        def initialize
          @redis_client = nil
          @sse_namespace = 'such_naymspes'
          @max_queue_size=1000
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
