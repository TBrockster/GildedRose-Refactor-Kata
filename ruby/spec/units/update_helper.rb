def update_and_expect(item, expected_result)
  item.update_sell_in
  item.update_quality
  expect(item.quality).to eq(expected_result)
end