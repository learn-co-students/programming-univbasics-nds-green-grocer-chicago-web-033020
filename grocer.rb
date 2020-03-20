def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  
  i = 0
  while i < collection.length 
  if name == collection[i][:item] 
    return collection[i] 
end
i += 1
  end
  
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  
  new_hash = {}
  i = 0 
  while i < cart.length do
    item = cart[i]
 item_name = item[:item]
  if not new_hash[item_name]
    new_hash[item_name] = {:item => item[:item], :price => item[:price], :clearance => item[:clearance], :count => 1}
  else
     new_hash[item_name][:count] += 1
end
  i += 1
  end
  new_hash.map{|key,value| value}
end


#.to_f (to float)

def get_coupon(item, coupons)
  for coupon in coupons do
    if item[:item] == coupon[:item]
      return coupon
    end
  end
  nil
  
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
    new_array = []
  for item in cart do
    coupon = get_coupon(item, coupons)
    if coupon
      discounted_price = coupon[:cost] / coupon[:num]
      discounted_item = {:item => item[:item] + " W/COUPON", :price => discounted_price,
        :clearance => item[:clearance], :count => coupon[:num]}
      new_array.push(discounted_item)
      no_sale_item = {:item => item[:item],:price => item[:price], :clearance => item[:clearance], :count => item[:count] - coupon[:num]}
        new_array.push(no_sale_item)
    else
      new_array.push(item)
    end
  end
  new_array
  
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  cart.map{|item|
new_hash = {:item => item[:item],:price => (item[:price] * 0.8).round(2), :clearance => item[:clearance], :count => item[:count]}
if item[:clearance]
  new_hash
else
  item
end
}
  
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
  
  consolidated_cart = consolidate_cart(cart)
  discounted_cart = apply_coupons(consolidated_cart, coupons)
  clearance_cart = apply_clearance(discounted_cart)

  gross_total = clearance_cart.reduce(0){|total, item| total + item[:price] * item[:count]}
  if gross_total > 100
    gross_total * 0.9
  else
    gross_total
  end
  
end
