module FrameValidator
    def validate_non_last_frame frame
        validate [   
            lambda {frame.all? {|i| i.is_a?(Integer) } },
            lambda {frame.length == 2 },
            lambda {frame.reduce(:+) <= 10},
        ]
    end
    
    def validate_last_frame frame
        validate [
            lambda {frame.all? {|i| i.is_a?(Integer) }} ,
            lambda {frame.length == 3} ,
            lambda {frame.reduce(:+) <= 30} ,
            lambda {frame[0..1].reduce(:+) < 10 ? frame[-1] == 0 : true} ,
        ]
    end
private 
    def validate rules
        rules.reduce(true) {|current, validator| current ? validator.call : current}
    end
end

