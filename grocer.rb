
def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  # Consult README for inputs and outputs
  # Collection is an array of hashes
  i = 0
  while i < collection.length
    if name == collection[i][:item]
      return collection[i]
    end
    i += 1
  end
  nil
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  # Cart is a collection of item hashes
  i = 0
  new_cart = []
  while i < cart.length
    new_cart_item = find_item_by_name_in_collection(cart[i][:item], new_cart)
    if new_cart_item != nil
      new_cart_item[:count] += 1
    else
      new_cart_item = {
        :item => cart[i][:item],
        :price => cart[i][:price],
        :clearance => cart[i][:clearance],
        :count => 1
      }
      new_cart << new_cart_item
    end
    i += 1
  end
  new_cart
end

#result has the following structure!! [{:item => "AVOCADO", :price => 3.00,:clearance => true, :count => 2}]

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart

  #figure out what to loop through, loop through cart and see if coupon applies and apply if does, or loop through array of coupons and check cart to see if cart has item in it and has enough of that item in it for coupon to apply
  i = 0
  while i < coupons.length
    cart_item = find_item_by_name_in_collection(coupons[i][:item], cart)
    #finds item that's listed in the coupon array and uses that item to search through cart array to see if present
    couponed_item_name = "#{coupons[i][:item]} W/COUPON"
    #when coupon is applied to an item- it must be reflected in the consolidated receipt
    cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
    #searches for item that has a coupon attached in the cart array to see if it has more than 1 (will return item name with coupon or nil)
    if cart_item && cart_item[:count] >= coupons[i][:num]
    #checks if cart_item exists in cart, and if the count is larger or equal to the coupon number
      if cart_item_with_coupon #if cart item is found with coupon, then returns truthy value, otherwise, is nil, a falsey value which does not execute the code
        cart_item_with_coupon[:count] += coupons[i][:num]
        #if truthy, then the :count of the cart_item_with_coupon is equal to cart_item_with_coupon + the number on the coupon
        cart_item[:count] -= coupons[i][:num]
        #access count of items and subtract the number that the coupon applies to
      else
        cart_item_with_coupon = {
          :item => couponed_item_name,
          :price => coupons[i][:cost]/coupons[i][:num],
          :clearance => cart_item[:clearance],
          :count => coupons[i][:num]
        }
        cart << cart_item_with_coupon
        cart_item[:count] -= coupons[i][:num]
      end
    end
    i += 1
  end
  cart
end
#given array is an array of hashes [{:item => "Avocado", :price => 3.00, :clearance => true, :count => 2}]
#^^ basically consolidated cart array (above method)
#coupon array {:item => "AVOCADO", :num => 2, :cost => 5.00}]

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  i = 0
  while i < cart.length
    if cart[i][:clearance] == true
      cart[i][:price] = (cart[ i][:price] * 0.80).round(2)
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
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)

  total = 0
  i = 0

  while i < final_cart.length do
    total += final_cart[i][:count] * final_cart[i][:price]
    i += 1
  end
  if total > 100
    total -= (total * 0.10)
  end
  total
end
