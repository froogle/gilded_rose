class GildedRose
  def initialize(items)
    @items = items
  end

  def increase_item_quality(item)
    item.quality += 1 if item.quality < 50
  end

  def decrease_item_quality(item)
    item.quality -= 1 if item.quality > 0
  end

  def age_item( item ) 
    if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
      decrease_item_quality item
      decrease_item_quality item if item.name.start_with?("Conjured")
    else
      increase_item_quality item
      if item.name == "Backstage passes to a TAFKAL80ETC concert"
        increase_item_quality item if item.sell_in < 11
        increase_item_quality item if item.sell_in < 6
      end
    end
  end

  def expire_item(item)
    if item.name != "Aged Brie"
      if item.name != "Backstage passes to a TAFKAL80ETC concert"
        decrease_item_quality item
      else
        item.quality = item.quality - item.quality
      end
    else
      increase_item_quality item
    end
  end

  def update_quality()
    @items.each do |item|
      next if item.name == "Sulfuras, Hand of Ragnaros"
      age_item item
      
      item.sell_in = item.sell_in - 1
      
      expire_item item if item.sell_in < 0
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
