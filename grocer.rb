def find_item_by_name_in_collection(name, collection)
  index = 0 
  while index < collection.length do 
    if collection[index][:item] == name 
     return collection[index]
    else 
      index += 1 
    end
  end
end
  # Implement me first!
  #
  # Consult README for inputs and outputs

def consolidate_cart(cart)
  index = 0
  new_cart = []
  while index < cart.length do
    name = cart[index][:item]
      if find_item_by_name_in_collection(name, new_cart)
        find_item_by_name_in_collection(name, new_cart)[:count] += 1
      else
        new_cart << {
          item: cart[index][:item],
          price: cart[index][:price],
          clearance: cart[index][:clearance],
          count: 1}
      end
    index += 1
  end
  new_cart
end

def apply_coupons(cart, coupons)
  index = 0
  original_cart_length = cart.length
  while index < original_cart_length do
    item_name = cart[index][:item]
    coupons_name = find_item_by_name_in_collection(item_name, coupons)
    if coupons_name && cart[index][:count] >= coupons_name[:num]
      if cart[index][:count] == coupons_name[:num] || cart[index][:count] % coupons_name[:num] == 0
        cart << {
          item: "#{item_name} W/COUPON",
          price: coupons_name[:cost] / coupons_name[:num],
          clearance: cart[index][:clearance],
          count: cart[index][:count]
        }
        cart[index][:count] -= cart[-1][:count]
      else
        remainder = cart[index][:count] % coupons_name[:num]
        original_count = cart[index][:count]
        cart[index] = {
          item: item_name,
          price: cart[index][:price],
          clearance: cart[index][:clearance],
          count: remainder
        }
        cart << {
          item: "#{item_name} W/COUPON",
          price: coupons_name[:cost] / coupons_name[:num],
          clearance: cart[index][:clearance],
          count: original_count - remainder
        }
      end
    else
     cart[index]
    end
    index += 1
  end
  cart
end

def apply_clearance(cart)
  index = 0 
  while index < cart.length do 
    if cart[index][:clearance] == true 
      new_price = (cart[index][:price] * 0.8).round(1)
      cart[index][:price] = new_price
    end
    index += 1 
  end
  cart 
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  coupons_applied = apply_coupons(consolidated_cart, coupons)
  clearance_applied = apply_clearance(coupons_applied)
  
  index = 0 
  grand_total = 0 
  while index < clearance_applied.length do 
    item_total = clearance_applied[index][:price] * clearance_applied[index][:count]
    grand_total += item_total
    index += 1
  end
  if grand_total > 100
    new_total = grand_total * 0.9
  else
     new_total = grand_total
  end
  new_total
end
