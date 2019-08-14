require_relative './bowl'

describe 'Bowl' do
    let(:name) { 'player' }
    let(:game) { Bowl.new name}
    let (:initialBoard) { {
        "player" => []
    }
}
    it 'should get current player board' do 
        expect(game.player_board).to eq(initialBoard)
    end

    it 'should add frame for a given name' do 
        frame = [1,2]

        expect((game).send(:submit_frame, name, frame)).to eq([frame])
    end
    
    it 'should get scores' do 
        score = [10]
        allow(game).to receive(:build_score_board).with(initialBoard['player']).and_return(score)

        expect(game.get_scores).to eq({'player' => score})
    end

    describe 'add_frame' do
        FRAME = [2,3]
        it 'should add a frame with 2 bowls for rounds less than 10 ' do 
            
            expect(game.add_frame name, FRAME).to eq([FRAME])
        end
        
        it 'should add a frame with 3 bowls for round 10 ' do 
            
            currentFrame = []
            9.times do
                currentFrame << FRAME
            game.add_frame name, FRAME
            end
            lastFrame = [10,10,10]
            expect(game.add_frame name, lastFrame).to eq(currentFrame << lastFrame)
        end
        
        it 'should return error message if frame is invalid for non-10th bowl' do 
            allow(game).to receive(:validate_non_last_frame).and_return false 
            
            expect(game.add_frame name, FRAME).to eq("Invalid name or frame, frameNumber: 1, frame: #{FRAME}")
        end
        it 'should return error message if frame is invalid for 10th bowl' do 
            allow(game).to receive(:validate_last_frame).and_return false

            currentFrame = []
            9.times do
                currentFrame << FRAME
            game.add_frame name, FRAME
            end
            
            expect(game.add_frame name, FRAME).to eq("Invalid name or frame, frameNumber: 10, frame: #{FRAME}")
        end
    end
end

