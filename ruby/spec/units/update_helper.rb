# frozen_string_literal: true

def update_inventory(store)
  store.update_inventory
end

def update_and_expect_quality(item, expected_result)
  item.update_sell_in
  item.update_quality
  expect(item.quality).to eq(expected_result)
end

def update_and_expect_sell_in(item, expected_result)
  item.update_sell_in
  expect(item.sell_in).to eq(expected_result)
end

def update_inventory_and_expect_sell_in(item, expected_result)
  update_inventory(GildedRose.new(item))
  expect(item[0].sell_in).to eq(expected_result)
end

def update_inventory_and_expect_quality(item, expected_result)
  update_inventory(GildedRose.new(item))
  expect(item[0].quality).to eq(expected_result)
end
