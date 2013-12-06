require 'texter'

describe Texter do
  
  let(:texter){Texter.new}
  let(:message){{from: '+14159341234',
                 to: '+16105557069',
                 body: 'Hey there!'}}
  
  xit 'should validate a message with a from, to, & body' do
    texter.valid?(message).should be_true
  end
end
