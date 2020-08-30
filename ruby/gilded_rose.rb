class GildedRose

  MINIMUM_QUALITY = 0 
  MAXIMUM_QUALITY = 50
  TEN_DAYS = 10
  FIVE_DAYS = 5

  BACKSTAGE_PASS = "Backstage passes to a TAFKAL80ETC concert"
  AGED_BRIE = "Aged Brie"
  SUFURAS = "Sulfuras, Hand of Ragnaros"
  CONJURED_ITEM = "Conjured"

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.select {|item| item.name != SULFURAS}.each do |item|
      age_item item
      item.sell_in -= 1
      expire_item item if past_sell_by? item
    end
  end

private

  def conjured_item?(item)
    item.name.start_with?(CONJURED_ITEM)
  end

  def past_sell_by?(item)
    item.sell_in < 0
  end

  def increase_item_quality(item)
    item.quality += 1 if item.quality < MAXIMUM_QUALITY
  end

  def decrease_item_quality(item)
    item.quality -= 1 if item.quality > MINIMUM_QUALITY
  end

  def age_item(item)
    if item.name != AGED_BRIE and item.name != BACKSTAGE_PASS
      decrease_item_quality item
      decrease_item_quality item if conjured_item? item
    else
      increase_item_quality item
      if item.name == BACKSTAGE_PASS
        increase_item_quality item if item.sell_in <= TEN_DAYS
        increase_item_quality item if item.sell_in <= FIVE_DAYS
      end
    end
  end

  def expire_item(item)
    if item.name != AGED_BRIE
      if item.name != BACKSTAGE_PASS
        decrease_item_quality item
      else
        item.quality = item.quality - item.quality
      end
    else
      increase_item_quality item
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
