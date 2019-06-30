class GildedRose
  def initialize(items)
    @items = items
  end

  def reduce_quality(item)
    if item.quality > 0
      item.quality = if ['Sulfuras', 'Hand of Ragnaros'].include?(item.name)
                       80
                     elsif item.name == 'Firestones' # Firestones are Conjured items
                       item.quality - 2
                     else
                       item.quality - 1
                     end
    end
  end

  def increase_quality(item)
    item.quality = item.quality + 1 if item.quality < 50
    if item.name == 'Backstage passes to a TAFKAL80ETC concert' && item.quality < 50
      item.quality = item.quality + 1 if item.quality < 50 && item.sell_in < 11
      item.quality = item.quality + 1 if item.quality < 50 && item.sell_in < 6
    end
  end

  def update_quality
    @items.each do |item|
      if (item.name != 'Aged Brie') && (item.name != 'Backstage passes to a TAFKAL80ETC concert')
        reduce_quality(item)
      else
        increase_quality(item)
      end
      unless ['Sulfuras', 'Hand of Ragnaros'].include?(item.name)
        item.sell_in = item.sell_in - 1
      end
      if item.sell_in < 0
        if item.name != 'Aged Brie'
          if item.name != 'Backstage passes to a TAFKAL80ETC concert'
            reduce_quality(item)
          else
            item.quality = item.quality - item.quality
          end
        elsif item.quality < 50
          item.quality = item.quality + 1
        end
      end
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

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
