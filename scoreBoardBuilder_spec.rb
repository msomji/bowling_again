require_relative './scoreBoardBuilder'

describe 'ScoreBoardBuilder' do 
    class ScoreBoardBuilderTestClass
        extend ScoreBoardBuilder
    end

    describe 'is_strike?' do
        it 'should return true if is strike' do 
            expect(ScoreBoardBuilderTestClass.is_strike?([10,0])).to eq(true)
        end
        
        it 'should return false if it is not a strike' do 
            expect(ScoreBoardBuilderTestClass.is_strike?([1,9])).to eq(false)
        end
    end
    
    describe 'is_spare?' do
        it 'should return true if it is a spare' do 
            expect(ScoreBoardBuilderTestClass.is_spare?([1,9])).to eq(true)
        end
        
        it 'should return false if it is not a spare' do 
            expect(ScoreBoardBuilderTestClass.is_spare?([1,8])).to eq(false)
        end
    
        it 'should return false if it is not a strike' do 
            expect(ScoreBoardBuilderTestClass.is_spare?([10,0])).to eq(false)
        end
    end

    describe 'sum_frame' do
        it 'should sum the frame' do
            expect(ScoreBoardBuilderTestClass.sum_frame([2,3])).to eq(5)
        end
    end
    
    describe 'sum_spare' do
        it 'should add the first roll of the next bow to current frame' do
             foo = [2,3]
             bar = [2,3]
            expect(ScoreBoardBuilderTestClass.sum_spare(foo, bar)).to eq(7)
            expect(foo).to eq([2,3])
            expect(bar).to eq([2,3])
        end
    end

    describe 'sum_strike' do
        it 'should add the next two rolls to current frame' do
            expect(ScoreBoardBuilderTestClass.sum_strike([10,0], [3,5], [3,4])).to eq(18)
        end
        
        it 'should add the next two rolls to current frame even if the next one is a strike' do
            expect(ScoreBoardBuilderTestClass.sum_strike([10,0], [10,0], [4,0])).to eq(24)
        end
      
        it 'should calculate strike on 8th frame' do
            expect(ScoreBoardBuilderTestClass.sum_strike([10,0],[10,0], [10,10,0])).to eq(30)
        end
        it 'should calculate strike on 9th frame' do
            expect(ScoreBoardBuilderTestClass.sum_strike([10,0], [10,10,0], [0,0])).to eq(30)
        end

        it 'should calculate strike on 10th frame' do
            expect(ScoreBoardBuilderTestClass.sum_strike([10,10,10], [0,0], [0,0])).to eq(30)
        end
    end

    describe 'cumulative_frame_sum' do 
        it 'should return an array of the cumulative sums at each frame' do
            sum_frames = [5,6,8,2,5,3]
            cumulative_frame_sums = [5, 11, 19,21,26,29]

            expect(ScoreBoardBuilderTestClass.cumulative_frame_sum sum_frames).to eq cumulative_frame_sums
        end
    end

    describe 'build_score_board' do
        it 'should build the scoreboard for all strike' do
            sum_frames = [
                [10,0],
                [10,0],
                [10,0],
                [10,0],
                [10,0],
                [10,0],
                [10,0],
                [10,0],
                [10,0],
                [10,10, 10],
            ]
            cumulative_frame_sums =[30, 60, 90, 120, 150, 180, 210, 240, 270, 300]

            expect(ScoreBoardBuilderTestClass.build_score_board sum_frames).to eq cumulative_frame_sums
        end

        it 'should build the scoreboard for spare on 10th frame' do
            sum_frames = [
                [1,0],
                [1,0],
                [1,0],
                [1,0],
                [1,0],
                [1,0],
                [1,0],
                [1,0],
                [1,0],
                [1,9, 10],
            ]
            cumulative_frame_sums = [1, 2, 3, 4, 5, 6, 7, 8, 9, 29]

            expect(ScoreBoardBuilderTestClass.build_score_board sum_frames).to eq cumulative_frame_sums
        end

        it 'should build the scoreboard for all spares' do
            sum_frames = [
                [1,9],
                [1,9],
                [1,9],
                [1,9],
                [1,9],
                [1,9],
                [1,9],
                [1,9],
                [1,9],
                [1,9, 10],
            ]
            cumulative_frame_sums = [11, 22, 33, 44, 55, 66, 77, 88, 99, 119]

            expect(ScoreBoardBuilderTestClass.build_score_board sum_frames).to eq cumulative_frame_sums
        end
    end
end
