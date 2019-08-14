
module ScoreBoardBuilder
    def build_score_board frames
        sum_array = []

        frames.each_with_index do |frame, index|
            if(is_strike?(frame)) 
                sum_array << sum_strike(frame, frames[index +1] || [0], frames[index +2] || [0])
            elsif(is_spare?(frame)) 
                sum_array << sum_spare(frame, frames[index +1]|| [0])
            else 
                sum_array << sum_frame(frame)
            end
        end
        cumulative_frame_sum sum_array
    end

    def is_strike? frame 
        frame == [10, 0]
    end
    
    def sum_frame frame 
        frame.reduce(:+) || 0 
    end

    def is_spare? frame 
        !is_strike?(frame) && sum_frame(frame) == 10
    end

    def sum_spare frame, nextFrame
         sum_frame ([frame, nextFrame[0]].flatten)
    end
    
    def sum_strike frame, nextFrame, thirdFrame
         lastFrame = nextFrame[2] != nil ? [nextFrame[2]] : [thirdFrame[0]]
        
        is_strike?(nextFrame.slice(0..1)) ? sum_frame([frame, nextFrame[0..1],lastFrame].flatten)
                                          : sum_frame([frame, nextFrame[0..1]].flatten)
    end

    def cumulative_frame_sum sum_array
        current_sum = 0
        sum_array.map  { |current| current_sum += current }
    end
end
