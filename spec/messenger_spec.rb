require 'messenger'

Mail.defaults do
  delivery_method :test 
end

describe Messenger do
  include Mail::Matchers

  before(:each) do
    Mail::TestMailer.deliveries.clear
    Messenger.new.send_message("test message")
  end
  
  it { should have_sent_email.from('simon.woolf+takeaway@gmail.com')\
                             .to('simon@simonwoolf.net')\
                             .with_subject()\
                             .with_body("test message") }
end
