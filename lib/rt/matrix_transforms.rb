module MatrixTransforms
  def zero
    new([
      [0, 0, 0, 0],
      [0, 0, 0, 0],
      [0, 0, 0, 0],
      [0, 0, 0, 0],
    ])
  end

  def identity
    new([
      [1, 0, 0, 0],
      [0, 1, 0, 0],
      [0, 0, 1, 0],
      [0, 0, 0, 1],
    ])
  end

  def translation(x, y, z)
    new([
      [1, 0, 0, x],
      [0, 1, 0, y],
      [0, 0, 1, z],
      [0, 0, 0, 1],
    ])
  end

  def scaling(x, y, z)
    new([
      [x, 0, 0, 0],
      [0, y, 0, 0],
      [0, 0, z, 0],
      [0, 0, 0, 1],
    ])
  end

  def rotation_x(rad)
    new([
      [1, 0,             0,              0],
      [0, Math.cos(rad), -Math.sin(rad), 0],
      [0, Math.sin(rad), Math.cos(rad),  0],
      [0, 0,             0,              1],
    ])
  end

  def rotation_y(rad)
    new([
      [Math.cos(rad),  0, Math.sin(rad), 0],
      [0,              1, 0,             0],
      [-Math.sin(rad), 0, Math.cos(rad), 0],
      [0,              0, 0,             1],
    ])
  end

  def rotation_z(rad)
    new([
      [Math.cos(rad), -Math.sin(rad), 0, 0],
      [Math.sin(rad), Math.cos(rad),  0, 0],
      [0,             0,              1, 0],
      [0,             0,              0, 1],
    ])
  end

  def shearing(xy, xz, yx, yz, zx, zy)
    new([
      [1,  xy, xz, 0],
      [yx, 1,  yz, 0],
      [zx, zy, 1,  0],
      [0,  0,  0,  1],
    ])
  end
end
