require 'mail'

class Messenger
  DEFAULT_CUSTOMER_EMAIL = 'simon@simonwoolf.net'
  DEFAULT_BUSINESS_EMAIL = 'simon.woolf+takeaway@gmail.com'
  DEFAULT_SUBJECT = 'Order confirmation'
  DEFAULT_MESSAGE = 'Order placed'
  DELIVERY_METHOD = :smtp

  MAIL_OPTIONS = { :address              => "smtp.gmail.com",
                   :port                 => 587,
                   :user_name            => 'simon.woolf@gmail.com',
                   :password             => '',#[password removed]
                   :authentication       => 'plain',
                   :enable_starttls_auto => true  }

  def initialize
  end

  def send_message(message)
    # could replace with send_text or whatever if twilio is back up.
    # Takeaway doesn't have to know what medium the message is
    send_email(message: message)
  end

  def send_email(from: DEFAULT_BUSINESS_EMAIL,
                 to:   DEFAULT_CUSTOMER_EMAIL,
                 subject: DEFAULT_SUBJECT,
                 message: DEFAULT_MESSAGE)
    mail = Mail.new
    mail.from = from
    mail.to = to
    mail.subject = subject
    mail.body = message
    mail.delivery_method DELIVERY_METHOD, MAIL_OPTIONS
    mail.deliver!
  end

end

