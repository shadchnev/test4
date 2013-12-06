require 'takeaway'

describe Takeaway do
  let(:takeaway){Takeaway.new}

  it 'should have some default menu items if instantiated with no menu' do
    takeaway = Takeaway.new
    #this reads way nicer than the expect syntax
    takeaway.menu.should_not be_empty
  end

  it 'should have the menu it\'s intantiated with' do
    getwasted = Takeaway.new(menu={'vodka' => 250})
    getwasted.menu.should == {'vodka' => 250}
  end

  xit 'should know the prices for the food it serves' do
  end
  
  it "should validate a correct order" do
    takeaway.validate_order(list: [['soylent red', 2],
                                   ['soylent blue', 3],
                                   ['soylent green', 1]], 
                            total: 4000).should be_true
  end

  it "should not validate an order with the wrong total" do
    takeaway.validate_order(list: [['soylent red', 2],
                                   ['soylent blue', 3],
                                   ['soylent green', 1]], 
                            total: 4001).should be_false
  end
end
