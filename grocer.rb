require 'pry'

def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  i = 0 
  hash1 = nil 
  while i < collection.size do 
    if name == collection[i][:item]
      hash1 = collection[i]
    end
    i += 1 
  end
  hash1
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  newcart = []
  i = 0 
  while i < cart.size 
    j = 0
    if i == 0 
      newcart << cart[i]
      newcart[-1][:count] = 1  
    else
      found = 0
      while j < newcart.size do 
        if newcart[j][:item] == cart[i][:item] 
          newcart[j][:count] += 1 
          found = 1
        end
        j += 1
      end
      if found == 0 
          newcart << cart[i]
          newcart[-1][:count] = 1
      end
    end
    i += 1 
  end
  newcart
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cc = 0 
  matchhash = {}
  while cc < coupons.size do
    matchhash = find_item_by_name_in_collection(coupons[cc][:item], cart)
    if matchhash[:count] >= coupons[cc][:num]
      remainder = matchhash[:count] % coupons[cc][:num]
      new_hash = {
        item: "#{matchhash[:item]} W/COUPON",
        price: coupons[cc][:cost] / coupons[cc][:num],
        clearance: matchhash[:clearance],
        count: matchhash[:count] -= remainder 
      }
      i = 0
      while matchhash[:item] != cart[i][:item] do 
        i += 1 
      end
      cart[i][:count] = remainder
      cart << new_hash
    end
    cc += 1
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  i = 0 
  
  while i < cart.size do
    if cart[i][:clearance] 
      cart[i][:price] = (cart[i][:price] * 0.8).round(2)
    end
    i += 1
  end
  cart
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
  newcart = apply_coupons(consolidate_cart(cart), coupons)
  newcart1 = apply_clearance(newcart)
  total = 0 
  i = 0 
  while i < newcart1.size do
    total += newcart1[i][:price] * newcart1[i][:count]
    i += 1
  end
  if total > 100 
    total = total * 0.9
  end
  total
end
