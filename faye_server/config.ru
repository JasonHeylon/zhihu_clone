require 'faye'
Faye::WebSocket.load_adapter('thin')

main_config = YAML.load_file("../config/config.yml")[ENV['RACK_ENV']]
FAYE_TOKEN = main_config["faye_token"]

faye_server = Faye::RackAdapter.new(:mount => '/faye', :timeout => 25)

class FayeAuth
  def incoming(message, callback)
    if message['channel'] !~ %r{^/meta/}
      if message["data"]
        if message["data"]['token'] != FAYE_TOKEN
          # Setting any 'error' against the message causes Faye to not accept it.
          message['error'] = "Faye authorize faild."
        else
          message["data"].delete('token')
        end
      end
    end
    callback.call(message)
  end
end
faye_server.add_extension(FayeAuth.new)

run faye_server