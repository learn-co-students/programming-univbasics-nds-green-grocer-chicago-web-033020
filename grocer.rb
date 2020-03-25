require 'pry'
def find_item_by_name_in_collection(name, collection)
 element_index = 0
 result = nil
 while element_index < collection.length do 
   if collection[element_index][:item] == name
     result = collection[element_index]
   end 
   element_index += 1 
 end 
 result
 end


 
      # Implement me first!
  #
  # Consult README for inputs and outputs


def consolidate_cart(cart)
  cart_array = []
  element_index  = 0
  while element_index < cart.length do 
    x = find_item_by_name_in_collection(cart[element_index][:item], cart_array)
    if x
      x[:count] += 1
    else 
      cart[element_index][:count] = 1
      cart_array << cart[element_index]
    end 
    element_index += 1
  end 
  cart_array 
end

  
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.

def apply_coupons(cart, coupons)
  element_index = 0
  after_coupons_array = []
  while element_index < cart.length do
  x = find_item_by_name_in_collection(cart[element_index][:item], coupons)
  if x && cart[element_index][:count] >= x[:num]
    coupon_hash = {} 
    coupon_hash[:clearance] = cart[element_index][:clearance]
    coupon_hash[:item] = x[:item] += " W/COUPON"
    coupon_hash[:price] = x[:cost] / x[:num]
    coupon_hash[:count] = x[:num]
    after_coupons_array << coupon_hash
    cart[element_index][:count] -= x[:num]
    after_coupons_array << cart[element_index]
  elsif coupons == []
    after_coupons_array = cart
  else 
    after_coupons_array << cart[element_index]
  end
  element_index += 1
  end
after_coupons_array
end
   # cart[element_index][:count] -= x[:num]
    # after_coupons_array << cart[element_index]

  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart


def apply_clearance(cart)
  
  after_clearance_array = []
  element_index = 0 
  while element_index < cart.length do
    if cart[element_index][:clearance]
      og_price = cart[element_index][:price]
      cart[element_index][:price] = (og_price * 0.8).round(2)
      after_clearance_array << cart[element_index]
    else
      after_clearance_array << cart[element_index]
    end
    element_index += 1
  end
  after_clearance_array
end 
       
       
   
 
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart


def checkout(cart, coupons)
  cc_array = consolidate_cart(cart)
  ac_array = apply_coupons(cc_array, coupons)
  c_array = apply_clearance(ac_array)
  
  #begin looping through cart to calculate total
  
  element_index = 0
  total = 0.00
  while element_index < c_array.length do
    total += c_array[element_index][:price] * c_array[element_index][:count]
    element_index += 1
  end 
  if total > 100.00
    final_total = total * 0.90
  else 
    final_total = total
  end
  final_total
end

  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
