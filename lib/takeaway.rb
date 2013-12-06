class Takeaway
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
    actual_total = list.inject(0) do |total, dish| 
      total += menu[dish[0]] * dish[1]
    end
    total == actual_total
  end
end
