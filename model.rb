require './constants.rb'

class Board
    attr_accessor :board, :board_previous
    def initialize(window, x=BoardX,y=BoardY)
        self.board_init(x, y)
        @board[48][41][0] = true
        @board[48][43][0] = true
        @board[47][43][0] = true
        @board[46][45][0] = true
        @board[45][45][0] = true
        @board[44][45][0] = true
        @board[43][47][0] = true
        @board[44][47][0] = true
        @board[45][47][0] = true
        @board[44][48][0] = true

        @window = window
        @image = Gosu::Image.new(@window, "./media/block_10x10.png", false)
    end

    def board_init(x, y)
        @board = []
        y.times{@board << []}
        @board.each do |arr|
            x.times{arr << [false, '']}
        end
    end

    def die(x, y)
        @board[y][x][0] = false
    end

    def generate(x, y)
        @board[y][x][0] = true
    end

    def check_dead_cell(x,y)
        return true if check_neighbors(x,y) == 3
        false
    end

    def check_live_cell(x,y)
        return false if check_neighbors(x,y) == 2 || check_neighbors(x,y) == 3
        true
    end

    def check_neighbors(x,y)
        live_count = 0
        if x == 0 && y == 0
            live_count += 1 if @board_previous[y+1][x][0] == true
            live_count += 1 if @board_previous[y][x+1][0] == true
            live_count += 1 if @board_previous[y+1][x+1][0] == true
        elsif x == BoardX - 1 && y == 0
            live_count += 1 if @board_previous[y+1][x][0] == true
            live_count += 1 if @board_previous[y][x-1][0] == true
            live_count += 1 if @board_previous[y+1][x-1][0] == true
        elsif x == BoardX - 1 && y == BoardY - 1
            live_count += 1 if @board_previous[y-1][x][0] == true
            live_count += 1 if @board_previous[y][x-1][0] == true
            live_count += 1 if @board_previous[y-1][x-1][0] == true
        elsif x == 0 && y == BoardY - 1
            live_count += 1 if @board_previous[y-1][x][0] == true
            live_count += 1 if @board_previous[y][x+1][0] == true
            live_count += 1 if @board_previous[y-1][x+1][0] == true
        elsif x == BoardX - 1
            live_count += 1 if @board_previous[y][x-1][0] == true
            live_count += 1 if @board_previous[y+1][x][0] == true
            live_count += 1 if @board_previous[y-1][x][0] == true
            live_count += 1 if @board_previous[y+1][x-1][0] == true
            live_count += 1 if @board_previous[y-1][x-1][0] == true
        elsif y == BoardY - 1
            live_count += 1 if @board_previous[y][x+1][0] == true
            live_count += 1 if @board_previous[y][x-1][0] == true
            live_count += 1 if @board_previous[y-1][x-1][0] == true
            live_count += 1 if @board_previous[y-1][x+1][0] == true
            live_count += 1 if @board_previous[y-1][x][0] == true
        elsif x == 0
            live_count += 1 if @board_previous[y][x+1][0] == true
            live_count += 1 if @board_previous[y+1][x+1][0] == true
            live_count += 1 if @board_previous[y-1][x+1][0] == true
            live_count += 1 if @board_previous[y+1][x][0] == true
            live_count += 1 if @board_previous[y-1][x][0] == true
        elsif y == 0
            live_count += 1 if @board_previous[y][x-1][0] == true
            live_count += 1 if @board_previous[y][x+1][0] == true
            live_count += 1 if @board_previous[y+1][x][0] == true
            live_count += 1 if @board_previous[y+1][x-1][0] == true
            live_count += 1 if @board_previous[y+1][x+1][0] == true
        else
            live_count += 1 if @board_previous[y][x+1][0] == true
            live_count += 1 if @board_previous[y][x-1][0] == true
            live_count += 1 if @board_previous[y+1][x][0] == true
            live_count += 1 if @board_previous[y-1][x][0] == true
            live_count += 1 if @board_previous[y+1][x-1][0] == true
            live_count += 1 if @board_previous[y-1][x+1][0] == true
            live_count += 1 if @board_previous[y-1][x-1][0] == true
            live_count += 1 if @board_previous[y+1][x+1][0] == true
        end
        live_count
    end

    def check_neighbors_wraparound(x,y)
        live_count = 0
        if x == BoardX - 1
            live_count += 1 if @board_previous[y][0][0] == true
            live_count += 1 if @board_previous[y][x-1][0] == true
            live_count += 1 if @board_previous[y+1][x][0] == true
            live_count += 1 if @board_previous[y-1][x][0] == true
            live_count += 1 if @board_previous[y+1][x-1][0] == true
            live_count += 1 if @board_previous[y-1][0][0] == true
            live_count += 1 if @board_previous[y-1][x-1][0] == true
            live_count += 1 if @board_previous[y+1][0][0] == true
        elsif x == BoardX - 1 && y == BoardY - 1
            live_count += 1 if @board_previous[y][0][0] == true
            live_count += 1 if @board_previous[y][x-1][0] == true
            live_count += 1 if @board_previous[0][x][0] == true
            live_count += 1 if @board_previous[y-1][x][0] == true
            live_count += 1 if @board_previous[0][x-1][0] == true
            live_count += 1 if @board_previous[y-1][0][0] == true
            live_count += 1 if @board_previous[y-1][x-1][0] == true
            live_count += 1 if @board_previous[0][0][0] == true
        elsif y == BoardY - 1
            live_count += 1 if @board_previous[y][x+1][0] == true
            live_count += 1 if @board_previous[y][x-1][0] == true
            live_count += 1 if @board_previous[0][x][0] == true
            live_count += 1 if @board_previous[y-1][x][0] == true
            live_count += 1 if @board_previous[0][x-1][0] == true
            live_count += 1 if @board_previous[y-1][x+1][0] == true
            live_count += 1 if @board_previous[y-1][x-1][0] == true
            live_count += 1 if @board_previous[0][x+1][0] == true
        else
            live_count += 1 if @board_previous[y][x+1][0] == true
            live_count += 1 if @board_previous[y][x-1][0] == true
            live_count += 1 if @board_previous[y+1][x][0] == true
            live_count += 1 if @board_previous[y-1][x][0] == true
            live_count += 1 if @board_previous[y+1][x-1][0] == true
            live_count += 1 if @board_previous[y-1][x+1][0] == true
            live_count += 1 if @board_previous[y-1][x-1][0] == true
            live_count += 1 if @board_previous[y+1][x+1][0] == true
        end
        live_count
    end

    def check_cells
        y = 0
        while y < BoardY
            x = 0
            while x < BoardX
                if @board_previous[y][x][0] == true
                    self.generate(x, y)
                    self.die(x, y) if self.check_live_cell(x, y)
                else
                    self.generate(x, y) if self.check_dead_cell(x, y)
                end
                x += 1
            end
            y += 1
        end
    end

    def draw
        y = 0
        while y < BoardY
            x = 0
            while x < BoardX
                @image.draw(x*BlockSize, y*BlockSize, 1) if @board[y][x][0] == true
                x += 1
            end
            y += 1
        end
    end

end



