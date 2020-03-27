def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  item_index = 0
  result = nil
  while item_index < collection.length do
    if collection[item_index][:item] == name
result = collection[item_index]
end
item_index += 1
end
result
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
cart_array = []
item_index = 0
  while item_index < cart.length do
    y = find_item_by_name_in_collection(cart[item_index][:item],cart_array)
  if y
    y[:count] += 1
  else
    cart[item_index][:count] = 1
    cart_array << cart[item_index]
end
item_index += 1
end
return cart_array
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  item_index = 0
  after_coup = []
  while item_index < cart.length do
    y = find_item_by_name_in_collection(cart[item_index][:item],coupons)
  if y && cart[item_index][:count] >= y[:num]
    coupon_hash = {}
    coupon_hash[:clearance] = cart[item_index][:clearance]
    coupon_hash[:item] = y[:item] += " W/COUPON"
    coupon_hash[:price] = y[:cost] / y[:num]
    coupon_hash[:count] = y[:num]
    after_coup << coupon_hash
    cart[item_index][:count] -= y[:num]
    after_coup << cart[item_index]
  elsif coupons == []
    after_coup = cart
  else
    after_coup << cart[item_index]
end
item_index += 1
end
after_coup
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  after_clearance = []
  item_index = 0
  while item_index < cart.length do
    if cart[item_index][:clearance]
      full_p = cart[item_index][:price]
      cart[item_index][:price] = (full_p * 0.8).round(2)
      after_clearance << cart[item_index]
    else
      after_clearance << cart[item_index]
end
item_index += 1
end
after_clearance
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  cc_cart = consolidate_cart(cart)
  apply_co = apply_coupons(cc_cart, coupons)
  apply_ar = apply_clearance(apply_co)
  item_index = 0
  total = 0.00
  while item_index < apply_ar.length do
    total += apply_ar[item_index][:price] * apply_ar[item_index][:count]
    item_index += 1
end
  if total > 100.00
    final_total = total * 0.90
  else
    final_total = total
end
final_total
end