def view_transform(from, to, up)
  forward = (to - from).normalize
  up_normalized = up.normalize
  left = forward.cross(up_normalized)
  true_up = left.cross(forward)

  result = Matrix.new([
    [left.x,     left.y,     left.z,     0],
    [true_up.x,  true_up.y,  true_up.z,  0],
    [-forward.x, -forward.y, -forward.z, 0],
    [0,          0,          0,          1]
  ])

  result * Matrix.translation(-from.x, -from.y, -from.z)
end
