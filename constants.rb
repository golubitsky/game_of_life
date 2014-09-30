BlockSize = 10
BoardX = 100
BoardY = 100

SHAPES = [ :square, :l_left, :l_right, :z_left, :z_right, :t, :long ].freeze

module ZOrder
    Background, Stars, Player, UI = *0..3
end
