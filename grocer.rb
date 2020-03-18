require 'pry'
=begin
Arguments:
          String: name of the item to find
          Array: a collection of items to search through
Returns:
        nil if no match is found
        the matching Hash if a match is found between the desired name and a given Hash's :item key
=end
# Consult README for inputs and outputs
# Collection is an array of hashes
def find_item_by_name_in_collection(name, collection)
  i = 0
  while i < collection.length do
    if name == collection[i][:item]
    return collection[i]
  end
    i += 1
   end
  nil#这个可写可不写
end
####################
=begin
Arguments:
Array: a collection of item Hashes
Returns:
a NEW Array where every UNIQUE item in the original is present
    Every item in this new Array should have a :count attribute
    Every item's :count will be at least 1
    Where multiple instances of a given item are seen, the instance in the new Array will have its `:count` increased.
REMEMBER: This returns a NEW Array that represents the cart. Don't merely
change cart (i.e. mutate) it. It's easier to return a new thing.
=end
def consolidate_cart(cart)
  cartAr = []
  i = 0
    while i<cart.length do
      itemTocartAr = find_item_by_name_in_collection(cart[i][:item], cartAr)
      if itemTocartAr#if exist                    item name to find, item collection to search through
    # if itemTocartAr!=nil 如果不等于 nil，如果并没有不存在，如果存在
        itemTocartAr[:count] += 1
      else
        itemTocartAr = {
          :item => cart[i][:item],
          :price => cart[i][:price],
          :clearance => cart[i][:clearance],
          :count => 1
        }
        cartAr << itemTocartAr
      end
      i += 1
    end
    cartAr
  end
###########
=begin
Arguments:
Array: a collection of item Hashes
Array: a collection of coupon Hashes
Returns:
A new Array.
Its members will be a mix of the item Hashes and, where applicable,
the "ITEM W/COUPON" Hash.
# REMEMBER: This method should update cart

=end
def apply_coupons(cart, coupons)
i = 0
  while i < coupons.length
    cart_item = find_item_by_name_in_collection(coupons[i][:item], cart)
    #find item from coupon array and use it to search throught cart array to see existence
    couponed_item_name = "#{coupons[i][:item]} W/COUPON"
    #display coupon is applied on receipt
    cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
    #searches for item that has a coupon attached in the cart array to see
    #if it has more than 1 same item (will return item name with coupon or nil)
        if cart_item && cart_item[:count] >= coupons[i][:num]
        #if there's enough item in the cart for applying coupon
        #if cart_item exists in cart AND its count value >=  the number value needed for apply coupon for item from coupon NDS
            if cart_item_with_coupon
            #if cart item is found with coupon, then returns truthy value, otherwise, is nil, a falsey value which does NOT execute the code
            cart_item_with_coupon[:count] += coupons[i][:num]
            #if truthy, count value of the item with coupon attached in cart
            # = count value of the item with coupon attached in cart + the number value needed for apply coupon for item from coupon NDS
            cart_item[:count] -= coupons[i][:num]
            #count value of items in cart - the number value of the coupon applied
            else
            #如果cart_item_with_coupon 不存在，we build it
            cart_item_with_coupon = {
            :item => couponed_item_name,
            :price => coupons[i][:cost]/coupons[i][:num],  #coupon显示的价格/coupon显示的数量要求
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
#######################
=begin
Arguments:
Array: a collection of item Hashes
Returns:
a new Array where every unique item in the original is present but with its price reduced by 20% if its :clearance value is true
This method should discount the price of every item on clearance by twenty percent.
# REMEMBER: This method *should* update cart
=end
def apply_clearance(cart)
  i=0
  while i < cart.length
    if cart[i][:clearance]==true
       cart[i][:price]=(cart[i][:price]*0.8).round(2)
    end
    i+=1
  end
  cart
end
##############################
=begin
Arguments:
Array: a collection of item Hashes
Array: a collection of coupon Hashes
Returns:
Float: a total of the cart
##################################################3
# This method should call
# * consolidate_cart
# * apply_coupons
# * apply_clearance
# BEFORE it begins the work of calculating the total (or else you might have
# some irritated customers
=end
def checkout(cart, coupons)
consolidated_cart = consolidate_cart(cart)
couponed_cart = apply_coupons(consolidated_cart, coupons)
final_cart = apply_clearance(couponed_cart)
  total_price=0
  i=0
    while i<final_cart.length
    total_price += final_cart[i][:price]*final_cart[i][:count]
    i+=1
    end

    if total_price>100
      total_price*=0.9
    end
  total_price
end
