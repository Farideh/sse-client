require 'test_helper'
require 'redis'

class PublishTest < MiniTest::Unit::TestCase
  include TestHelper

  def setup

    @sse_client=Sse::Client::Client.new
    @redis_client=Redis.new
    @ns="test_sse_celient"
    @limit=10
    @sse_client.configure do |config|
      config.redis_client=@redis_client
      config.sse_namespace=@ns
      config.max_queue_size=@limit
    end
    @channel="channels/test1"
    
  end

  def test_basic_publish
    self.clear_channel(@channel)
    
    @sse_client.publish(@channel, Time.now.to_i,{id:12,field1:"value1",field2:"value2"})
    assert_equal 1, @redis_client.zcard(namespaced_channel(@channel))
  end

  def test_limit_size
    self.clear_channel(@channel)

    @limit.times do |i|
      @sse_client.publish(@channel, Time.now.to_i-i,{id:i,field1:"value1",field2:"value2"})
    end
    assert_equal @limit, @redis_client.zcard(namespaced_channel(@channel))

    @sse_client.publish(@channel, Time.now.to_i,{id:@limit+1,field1:"value1",field2:"value2"})

    assert_equal @limit, @redis_client.zcard(namespaced_channel(@channel))    
  end

  def test_subscribe_publish
    #@TODO write an actual test
    assert true
  end

end
