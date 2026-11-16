require_relative '../../../helper'
require 'logger'
require 'stringio'

describe Gate::V4::Client do
  let(:log){StringIO.new}
  let(:api_key){'a_key'}

  subject do
    Gate::V4::Client.new(api_key: api_key, api_secret: 'a_secret', logger: Logger.new(log))
  end

  describe "request logging" do
    it "logs requests" do
      VCR.use_cassette('v4/spot/tickers_btc') do
        subject.spot_tickers(currency_pair: 'BTC_USDT')
      end
      _(log.string).must_match(%r{GET https://api.gateio.ws/api/v4/spot/tickers})
      _(log.string).must_match(/Args: \{currency_pair: "BTC_USDT"/)
      _(log.string).must_match(%r{Headers: .+"Content-Type" => "application/json"})
    end

    it "masks the key and not the signature" do
      VCR.use_cassette('v4/spot/tickers_btc') do
        subject.spot_tickers(currency_pair: 'BTC_USDT')
      end
      _(log.string).must_include(%{"KEY" => "[FILTERED]"})
      _(log.string).wont_include(api_key)
      _(log.string).must_match(/"SIGN" => "[^\[]/)
    end
  end

  describe "response logging" do
    it "logs responses" do
      VCR.use_cassette('v4/spot/tickers_btc') do
        subject.spot_tickers(currency_pair: 'BTC_USDT')
      end
      _(log.string).must_match(/INFO -- : Code: 200/)
      _(log.string).must_match(/Body: \[/)
    end

    it "logs errors" do
      VCR.use_cassette('v4/wallet/total_balance_with_an_invalid_key') do
        _{subject.wallet_total_balance(currency: 'BTC')}.must_raise(Gate::Error)
      end
      _(log.string).must_match(/ERROR -- : Code: 4\d\d/)
    end
  end
end
