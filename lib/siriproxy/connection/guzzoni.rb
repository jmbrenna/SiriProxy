#####
# This is the connection to the Guzzoni (the Siri server backend)
#####
class SiriProxy::Connection::Guzzoni < SiriProxy::Connection
  def initialize
    super
    self.name = "Guzzoni"
  end
  
  def connection_completed
    super
    start_tls(:verify_peer => false)
  end
  
  def received_object(object)
    if (object["v"] == "2.1")
        $siriversion = "2.1"
    end
    if (object["$v"] == "3.0")
        $siriversion = "3.0"
    end
    return plugin_manager.process_filters(object, :from_guzzoni)

    #plugin_manager.object_from_guzzoni(object, self)
  end
	
  def block_rest_of_session 
    @block_rest_of_session = true
  end
end
