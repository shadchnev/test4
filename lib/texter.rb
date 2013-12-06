require 'twilio-ruby'

class Texter
  ACCOUNT_SID = 'ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  AUTH_TOKEN = 'SDFSDF'
  REQUIRED_FIELDS = [:from, :to, :body]

  def initialize
    @client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
  end

  def send_sms(message)
    raise "malformed message" unless valid?(message)
    @client.account.messages.create(message)
  end

  def valid?(message)
    REQUIRED_FIELDS.all? {|field| message.has_key? field}
  end
end
