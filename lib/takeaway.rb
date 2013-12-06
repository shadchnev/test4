class Takeaway
  DELIVERY_DELAY = 60*60
  DEFAULT_MENU = {'soylent red' => 750,
                  'soylent blue' => 500,
                  'soylent green' => 1000}

  def initialize(menu=nil)
    @menu = menu
  end

  def menu
    # Prices in pence
    @menu ||= DEFAULT_MENU
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

  def send_success_message(delivery_time)
  end

  def success_message(delivery_time)
    formatted_time = delivery_time.strftime("%H:%M")
    "Order placed. Expected delivery time: #{formatted_time}"
  end
end
