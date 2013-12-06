class Takeaway
  DELIVERY_DELAY = 60*60
  
  def initialize(menu=nil)
    @menu = menu
  end

  def menu
    # Prices in pence
    @menu ||= {'soylent red' => 750,
               'soylent blue' => 500,
               'soylent green' => 1000, }
  end

  def validate_order(list: nil, total: nil)
    actual_total = list.inject(0) do |memo, item| 
      item_price = menu[item[:dish]] or raise "#{item[:dish]} is not on the menu"
      memo += item_price * [item[:quantity], 0].max
    end
    raise "Incorrect total" unless total == actual_total
  end

  def place_order(list: nil, total:nil)
    validate_order(list:list, total:total)
    send_success_text(Time.new + DELIVERY_DELAY)
  end

  def send_success_text(delivery_time)
  end

  def success_text(delivery_time)
    formatted_time = delivery_time.strftime("%H:%M")
    puts "Order placed. Expected delivery time: #{formatted_time}"
  end
end
