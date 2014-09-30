require 'gosu'

require './model.rb'
require './controller.rb'
require './constants.rb'

class GameWindow < Gosu::Window
    include ZOrder

    def initialize
        @width = BlockSize * BoardX
        @height = BlockSize * BoardY
        super @width, @height, false
        self.caption = "Game of Life"

        #@background_image = Gosu::Image.new(self, "./media/background.jpg", true)
        @model = Board.new(self)
        @controller = Controller.new
        @font = Gosu::Font.new(self, Gosu::default_font_name, 25)
    end

    def update
        @controller.timer += 1

        #if @controller.timer > 60 && @controller.timer % 1 == 0
            @model.board_previous = @model.board
            @model.board_init(BoardX, BoardY)
            @model.check_cells
        #end
    end

    def draw
          @model.draw
          #@font.draw("Level: #{10}", 300 , @height - 32, ZOrder::UI, 1.0, 1.0, 0xff00ff00)
    end

    def button_down(id)
        if id == Gosu::KbEscape
            close
        end
    end
end



window = GameWindow.new
window.show
