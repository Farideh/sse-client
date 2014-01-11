require 'sse/client'
require 'minitest/unit'
require 'minitest/autorun'
require 'minitest/pride'

module TestHelper
  def clear_channel(channel)
    @redis_client.del(self.namespaced_channel(channel))
  end
  def namespaced_channel(channel)
    @ns+":"+channel
  end
end
