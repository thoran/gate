require_relative '../../../helper'
require 'minitest/mock'

describe Gate::V4::Client do
  describe "a request which raises" do
    it "leaves no timestamp behind for the next request" do
      client = Gate::V4::Client.new(api_key: 'a_key', api_secret: 'a_secret')
      Time.stub(:now, Time.at(1)) do
        HTTP.stub(:get, ->(*){raise SocketError}) do
          _{client.spot_time}.must_raise(SocketError)
        end
      end
      sent = nil
      HTTP.stub(:get, ->(_uri, _args, headers){sent = headers; raise SocketError}) do
        _{client.spot_time}.must_raise(SocketError)
      end
      _(sent['Timestamp']).wont_equal('1')
    end
  end
end
