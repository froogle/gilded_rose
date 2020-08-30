class GildedRose

  #========== constants
  MINIMUM_QUALITY = 0
  MAXIMUM_QUALITY = 50
  TEN_DAYS = 10
  FIVE_DAYS = 5

  BACKSTAGE_PASS = "Backstage passes to a TAFKAL80ETC concert"
  AGED_BRIE = "Aged Brie"
  SULFURAS = "Sulfuras, Hand of Ragnaros"
  CONJURED_ITEM = "Conjured"

  def initialize(items)
    @items = items
  end

  #========== update quality of an item over time
  def update_quality()
    @items.select { |item| item.name != SULFURAS }.each do |item|
      age_item item
      item.sell_in -= 1
      expire_item item if past_sell_by? item
    end
  end

  
  
  #========== item quality methods
  private
  def age_item(item)
    if item_improves_with_age? item
      improve_item item
    else
      degrade_item item
    end
  end

  def expire_item(item)
    if item_improve_after_expiry? item
      increase_item_quality item
    else
      decrease_item_quality item
      item.quality = MINIMUM_QUALITY if item_worthless_after_expiry item
    end
  end

  def improve_item(item)
    increase_item_quality item
    if item.name == BACKSTAGE_PASS
      increase_item_quality item if item.sell_in <= TEN_DAYS
      increase_item_quality item if item.sell_in <= FIVE_DAYS
    end
  end

  def degrade_item(item)
    decrease_item_quality item
    decrease_item_quality item if conjured_item? item
  end

  def increase_item_quality(item)
    item.quality += 1 if item.quality < MAXIMUM_QUALITY
  end

  def decrease_item_quality(item)
    item.quality -= 1 if item.quality > MINIMUM_QUALITY
  end

  #========= business rules conditions
  def item_improves_with_age?(item)
    item.name == AGED_BRIE || item.name == BACKSTAGE_PASS
  end

  def item_improve_after_expiry?(item)
    item.name == AGED_BRIE
  end

  def item_worthless_after_expiry(item)
    item.name == BACKSTAGE_PASS
  end

  def conjured_item?(item)
    item.name.start_with?(CONJURED_ITEM)
  end

  def past_sell_by?(item)
    item.sell_in < 0
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
