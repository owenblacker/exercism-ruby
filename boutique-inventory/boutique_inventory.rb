class BoutiqueInventory
  def initialize(items)
    @items = items
  end
  def item_names
    @items.map { |item| item[:name] }.sort
  end
  def cheap
    @items.select { |item| item[:price] < 30.0 }
  end
  def out_of_stock
    @items.select { |item| item[:quantity_by_size] == {} }
  end
  def stock_for_item(name)
    #debug @items.select { |item| item[:name] == name }
    
    @items.select { |item|
        item[:name] == name
    }[0][:quantity_by_size]
  end
  def total_stock
    items_with_stock = @items.select { |item| !item[:quantity_by_size].empty? }
    quantities = items_with_stock.map { |item| item[:quantity_by_size].values }
    quantities.flatten.sum
  end
  private
  attr_reader :items
end
