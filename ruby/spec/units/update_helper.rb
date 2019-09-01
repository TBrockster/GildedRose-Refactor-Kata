def update_quality_and_expect(item, expected_result)
  item.update_sell_in
  item.update_quality
  expect(item.quality).to eq(expected_result)
end

def update_inventory_and_expect_sell_in(item, expected_result)
  GildedRose.new(item).update_inventory
  expect(item[0].sell_in).to eq(expected_result)
end

def update_inventory_and_expect_quality(item, expected_result)
  GildedRose.new(item).update_inventory
  expect(item[0].quality).to eq(expected_result)
end
