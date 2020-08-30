require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "should not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "fixme"
    end

    it "should degrade quality twice as fast after sell by date"

    it "should not allow quality to go below zero"

    it "should increase the quality of aged brie over time"

    it "should not increase the quality beyond 50"

    it "should not change the quality of sulfuras"

    it "should allow sulfuras to maintain a quality of 80"

    it "should increase the quality of a backstage pass by 2 ten days before the event"

    it "should increase the quality of a backstage pass by 3 5 days before the event"

    it "should reduce the quality of a backstage pass to 0 after the event"

    it "should degrade the quaklity of a conjured item doubly fast"

  end



end
