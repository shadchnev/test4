require 'messenger'

Mail.defaults do
  delivery_method :test 
end

describe Messenger do
  include Mail::Matchers

  before(:each) do
    Mail::TestMailer.deliveries.clear
    stub_const("Messenger::DELIVERY_METHOD", :test)
    messenger = Messenger.new
    messenger.send_message("test message")
  end
  
  it { should have_sent_email.from('simon.woolf+takeaway@gmail.com')\
                             .to('simon@simonwoolf.net')\
                             .with_subject('Order confirmation')\
                             .with_body("test message") }
end
