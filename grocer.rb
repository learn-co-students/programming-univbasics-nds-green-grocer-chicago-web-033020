require 'pry'

def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  
  i = 0 
  while i < collection.length do 
    
    if name == collection[i][:item]
      return collection[i]
    end 
    
    i += 1 
  end 
  
  nil
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  
  consolidated_cart = []
  
  i = 0  
  
  while i < cart.length do 
    
    item = cart[i][:item]
    
    does_item_exist = find_item_by_name_in_collection(item, consolidated_cart)
    
    if does_item_exist != nil 
      does_item_exist[:count] += 1
    else 
      does_item_exist = {
        :item => cart[i][:item],
        :price => cart[i][:price],
        :clearance => cart[i][:clearance],
        :count => 1
      }
     
      consolidated_cart << does_item_exist
    end 
      
    i += 1
  end 
  
  consolidated_cart
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
 
  i = 0 
  
  while i < coupons.length do 
    item_with_coupon = find_item_by_name_in_collection(coupons[i][:item], cart)
    cart_item_with_coupon = find_item_by_name_in_collection("#{coupons[i][:item]} W/COUPON", cart)
    
    if  (item_with_coupon) && (coupons[i][:num] <= item_with_coupon[:count])
      
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupons[i][:num]
        item_with_coupon[:count] -= coupons[i][:num]
        
      else 
        cart_item_with_coupon = {
        :item => "#{coupons[i][:item]} W/COUPON",
        :price =>  coupons[i][:cost]/coupons[i][:num],
        :clearance => item_with_coupon[:clearance],
        :count => coupons[i][:num] 
        }
        
        cart << cart_item_with_coupon 
        
        item_with_coupon[:count] -= coupons[i][:num] 
      
      end 
    
    end 
    
    i += 1
  end 
 
  cart
end

def apply_clearance(cart)
  i = 0 
  while i < cart.length do 
    item = cart[i] 
    if item[:clearance]
      item[:price] = (item[:price]*0.80).round(2)
    end 
    
    i += 1 
  end 
   
  cart   
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * final_cart = consolidate_cart
  # * apply_coupons(final_cart)
  # * apply_clearance(final_cart)
  # final_cart
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
total = 0 

  final_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(final_cart, coupons)
  clearance_cart = apply_clearance(coupon_cart)
  
  
  i = 0 
  while i < clearance_cart.length do 
    total += (clearance_cart[i][:price] * clearance_cart[i][:count]).round(2)
  
    i += 1
  end 
  
  if total > 100
    total = total * 0.90
  end 
  
  total 
end
