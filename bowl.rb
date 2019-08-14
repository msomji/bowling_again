require_relative './frameValidator'
require_relative './scoreBoardBuilder'

class Bowl
    include FrameValidator, 
           ScoreBoardBuilder
    attr_reader :player_board

    def initialize *names
        @player_board = names.inject({})  do | board, name| 
             board[name] = []
             board
        end
    end

    def get_scores
        @player_board.keys.reduce({}) do |scores, key|
            scores[key] = build_score_board(@player_board[key])
            scores
        end
    end

    def add_frame name, frame
        is_valid_frame =  @player_board[name].length < 9 ? validate_non_last_frame(frame) : validate_last_frame(frame)
        is_valid_frame ? submit_frame(name, frame) : "Invalid name or frame, frameNumber: #{@player_board[name].length + 1}, frame: #{frame}"
        
    end

    private

    def submit_frame name, frame
        @player_board[name] << frame
        @player_board[name]
    end
end
