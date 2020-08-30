require File.join(File.dirname(__FILE__), 'gilded_rose')

DUMMY_PRODUCT = "foo"
CONJURED_WAND = "Conjured wand of awesomeness"
CONJURED_AXE = "Conjured axe of chopping"

def updated_item( name:, sell_by:, quality: )
  items = [Item.new(name, sell_by, quality)]
  GildedRose.new(items).update_quality()
  items[0]
end

describe GildedRose do

  describe "#update_quality" do
    it "should not change the name" do
      expect(updated_item(name: DUMMY_PRODUCT, sell_by: 0, quality: GildedRose::MINIMUM_QUALITY).name).to eq DUMMY_PRODUCT
    end

    it "should degrade quality twice as fast after sell by date" do 
      expect(updated_item(name: DUMMY_PRODUCT, sell_by: -1, quality: 10).quality).to eq 8
    end

    it "should not allow quality to go below zero" do 
      expect(updated_item(name: DUMMY_PRODUCT, sell_by: -1, quality: GildedRose::MINIMUM_QUALITY).quality).to eq 0
    end

    it "should increase the quality of aged brie over time" do 
      expect(updated_item(name: GildedRose::AGED_BRIE, sell_by: 10, quality: GildedRose::MINIMUM_QUALITY).quality).to eq 1
    end

    it "should not increase the quality beyond 50" do 
      expect(updated_item(name: GildedRose::AGED_BRIE, sell_by:10, quality: GildedRose::MAXIMUM_QUALITY).quality).to eq 50
    end

    it "should not change the quality of sulfuras" do 
      expect(updated_item(name: GildedRose::SULFURAS, sell_by:10, quality: 40).quality).to eq 40
    end

    it "should allow sulfuras to maintain a quality of 80" do 
      expect(updated_item(name: GildedRose::SULFURAS, sell_by: 10, quality: 80).quality).to eq 80
    end

    it "should increase the quality of a backstage pass by 2 ten days before the event" do 
      expect(updated_item(name: GildedRose::BACKSTAGE_PASS, sell_by: 10, quality: 10).quality).to eq 12
    end

    it "should increase the quality of a backstage pass by 3 five days before the event" do 
      expect(updated_item(name: GildedRose::BACKSTAGE_PASS, sell_by: 5, quality: 10).quality).to eq 13
    end

    it "should reduce the quality of a backstage pass to 0 after the event" do 
      expect(updated_item(name: GildedRose::BACKSTAGE_PASS, sell_by: 0, quality: 10).quality).to eq 0
    end

    it "should degrade the quality of a conjured wand doubly fast" do 
      expect(updated_item(name: CONJURED_WAND, sell_by: 10, quality: 10).quality).to eq 8
    end

    it "should degrade the quality of a conjured axe doubly fast" do 
      expect(updated_item(name: CONJURED_AXE, sell_by: 10, quality: 10).quality).to eq 8
    end

    it "should not degrade a conjured item below zero" do 
      expect(updated_item(name: CONJURED_AXE, sell_by: 0, quality: 1).quality).to eq 0
    end

  end



end
