require 'takeaway'

describe Takeaway do
  let(:takeaway){Takeaway.new}
  let(:messenger_instance){double :messenger}
  
  it 'should have some default menu items if instantiated with no menu' do
    takeaway = Takeaway.new
    #this reads way nicer than the expect syntax
    # yep, it's funny this syntax is officially deprecated
    takeaway.menu.should_not be_empty
  end

  it 'should have the menu it\'s intantiated with' do
    # here you're creating a local variable menu that has nothing to do with Takeaway
    # Pointless?
    getwasted = Takeaway.new(menu={'vodka' => 250})
    getwasted.menu.should == {'vodka' => 250}
  end
  
  it "should not raise an error for a correct order" do
    lambda {takeaway.validate_order(
      list: [{dish:'soylent red', quantity:2},
             {dish:'soylent blue', quantity:3},
             {dish:'soylent green', quantity:1}], 
      total: 4000)}.should_not raise_error
  end

  it "should raise an error if wrong total" do
    lambda {takeaway.validate_order(
      list:[{dish:'soylent red', quantity:2},
            {dish:'soylent blue', quantity:3},
            {dish:'soylent green', quantity:1}], 
      total: 4001)}.should raise_error("Incorrect total")
  end

  it "should not validate an order with a negative number of a dish" do
    lambda {takeaway.validate_order(
      list: [{dish:'soylent red', quantity:1},
             {dish:'soylent blue', quantity:-1}],
      total: 250)}.should raise_error
  end

  it 'should raise an error if an item not on the menu is given' do
    lambda {takeaway.validate_order(
      list:[{dish: 'escargot', quantity:3}],
      total: 1000)}.should raise_error("escargot is not on the menu")
  end

  it 'should validate and send a success message when placing an order' do
    takeaway.stub(:send_success_message)
    takeaway.stub(:validate_order){true}
    takeaway.should_receive(:validate_order)
    takeaway.should_receive(:send_success_message)
    takeaway.place_order
  end

  it 'should be able to send a text message' do
    takeaway.stub(:messenger){messenger_instance}    
    messenger_instance.should_receive(:send_message).with("Order placed. Expected delivery time: 00:00")
    takeaway.send_success_message(Time.new(0))
  end
end
