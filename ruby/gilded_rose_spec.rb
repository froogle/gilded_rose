require File.join(File.dirname(__FILE__), 'gilded_rose')

def updated_item( name:, sell_by:, quality: )
  items = [Item.new(name, sell_by, quality)]
  GildedRose.new(items).update_quality()
  items[0]
end



describe GildedRose do

  describe "#update_quality" do
    it "should not change the name" do
      expect(updated_item(name: "foo", sell_by: 0, quality: 0).name).to eq "foo"
    end

    it "should degrade quality twice as fast after sell by date" do 
      expect(updated_item(name: "something", sell_by: -1, quality: 10).quality).to eq 8
    end

    it "should not allow quality to go below zero"

    it "should increase the quality of aged brie over time"

    it "should not increase the quality beyond 50"

    it "should not change the quality of sulfuras"

    it "should allow sulfuras to maintain a quality of 80"

    it "should increase the quality of a backstage pass by 2 ten days before the event"

    it "should increase the quality of a backstage pass by 3 five days before the event"

    it "should reduce the quality of a backstage pass to 0 after the event"

    it "should degrade the quality of a conjured item doubly fast"

  end



end
