require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  describe '#update_quality' do
    context 'name' do
      it 'does not change the name' do
        items = [Item.new('foo', 0, 0)]
        GildedRose.new(items).update_quality
        expect(items[0].name).to eq 'foo'
      end
    end

    context 'legendary items' do
      it 'does not change the quality' do
        items = [Item.new('Sulfuras', 10, 80)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 80
      end
      it 'does not change the sell_in' do
        items = [Item.new('Sulfuras', 10, 80)]
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq 10
      end
    end

    context 'normal items' do
      it 'degrades quality twice as fast' do
        items = [Item.new('foo', -1, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 8
      end

      it 'does not degrade quality to negative' do
        items = [Item.new('foo', -1, 0)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 0
      end

      it 'reduces sell_in number' do
        items = [Item.new('foo', 10, 20)]
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq 9
      end
    end

    context 'aged brie' do
      it 'increases quality of Aged Brie the older it gets' do
        items = [Item.new('Aged Brie', 10, 20)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 21
      end

      it 'does not incease the quality to more than 50' do
        items = [Item.new('Aged Brie', 10, 50)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 50
      end

      it 'reduces sell_in number' do
        items = [Item.new('Aged Brie', 10, 50)]
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq 9
      end
    end

    context 'backstage passes' do
      it 'increases quality by two' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 20)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 22
      end

      it 'increases quality by three' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 20)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 23
      end

      it 'drops quality to zero' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 20)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 0
      end

      it 'does not incease the quality to more than 50' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 49)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 50
      end

      it 'reduces sell_in number' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 49)]
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq 9
      end
    end

    context 'Conjured items' do
      it 'drops degrade quality twice as fast as normal items' do
        items = [Item.new('Firestones', 23, 20)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 18

        items = [Item.new('Firestones', -1, 20)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 16
      end

      it 'reduces sell_in number' do
        items = [Item.new('Firestones', 10, 49)]
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq 9
      end
    end
  end
end
