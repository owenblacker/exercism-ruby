class BoutiqueInventory
  attr_reader :items

  def initialize(items)
    @items = items.map { |item| OpenStruct.new(item) }
  end

  def item_names
    items.map(&:name).sort
  end

  def total_stock
    all_quantities = items.map(&:quantity_by_size)
    
    return all_quantities.map(&:values).flatten.sum
    
    #items.sum do |item|
    #  item[:quantity_by_size].values.sum
    #end

    raise "Refactor the code in total_stock"
  end
end
