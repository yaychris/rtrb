def dot(lh, rh)
  lh.zip(rh).inject(0) { |sum, (l, r)| sum + l*r }
end

def is_odd?(x)
  !is_even?(x)
end

def is_even?(x)
  x % 2 == 0
end

class Float
  def to_fixed(precision = 5)
    round(precision)
  end
end
