require 'pry'

#{"AVOCADO" => {:price => 3.0, :clearance => true, :count => 2},

def consolidate_cart(cart)
  new_obj = {}

  cart.each do |objects|
    objects.each do |item_name, item_data|
      if new_obj.has_key?(item_name) == false
        item_data[:count] = 1
        new_obj[item_name] = item_data
      elsif new_obj.has_key?(item_name)
        item_data[:count] += 1
        new_obj[item_name] = item_data
      end#if the new obj does not have the key then place it in the new_obj
    end#end of iterating through each object
  end#end iterating through the cart array of objects

  new_obj
end#end of function

def apply_coupons(cart, coupons)
  new_cart = {}

  cart.each do |item_name, item_data|
    new_cart[item_name] = item_data
    coupons.each do |coupon_obj|
      if item_name == coupon_obj[:item]
        binding.pry
        couponName = "#{item_name.upcase} W/COUPON"
        new_cart[couponName] = {:price => coupon_obj[:cost], :clearance => true, :count => 1}
        new_cart[item_name][:count] -= coupon_obj[:num]
        #trying to deal with multiple coupons
        while new_cart[item_name][:count] >= coupon_obj[:num]
           new_cart[couponName][:price] *= 2
           new_cart[couponName][:count] += 1
           new_cart[item_name][:count] -= coupon_obj[:num]
         end
      end
    end

    cart = new_cart
  end#end of cart.each

  cart
end#end of function

def apply_clearance(cart)
  cart.each do |item_name, data_obj|
    if data_obj[:clearance] == true
      data_obj[:price] -= data_obj[:price] * 0.2
    end
  end
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart:[], coupons:[])
  cart = apply_clearance(cart:[])
  binding.pry
end
