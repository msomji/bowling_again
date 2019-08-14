require_relative './frameValidator'

describe 'FrameValidator' do
        class BowlValidatorTestClass
            extend FrameValidator
        end

    describe 'validate_non_last_frame' do 
        it 'should return true when frame totals to 10 or less' do
            expect(BowlValidatorTestClass.validate_non_last_frame([3,4])).to eq(true)
        end
        
        it 'should return false when frame totals more than 10' do
            expect(BowlValidatorTestClass.validate_non_last_frame([30,4])).to eq(false)
        end
        it 'should return false when frame does not have correct length' do
            expect(BowlValidatorTestClass.validate_non_last_frame([1,4,3])).to eq(false)
        end
        
        it 'should return false when frame contains anything other than integers' do
            expect(BowlValidatorTestClass.validate_non_last_frame([1,p])).to eq(false)
        end
    end

    describe 'validate_last_frame' do 
        it 'should return false when frame more than 10 in first two index' do
            expect(BowlValidatorTestClass.validate_last_frame([30,4, 3])).to eq(false)
        end
        it 'should return false when frame more than 10 in last index' do
            expect(BowlValidatorTestClass.validate_last_frame([3,4, 90])).to eq(false)
        end
        
        it 'should return false when frame does not have correct length' do
            expect(BowlValidatorTestClass.validate_last_frame([1,4])).to eq(false)
        end
        
        it 'should return false when frame contains anything other than integers' do
            expect(BowlValidatorTestClass.validate_last_frame([1,4,p])).to eq(false)
        end

        it 'should return true when frame contains all three strikes' do
            expect(BowlValidatorTestClass.validate_last_frame([10,10,10])).to eq(true)
        end
        
        it 'should return false when frame contains 3 rolls but no spare in first two rolls' do
            expect(BowlValidatorTestClass.validate_last_frame([5,0,10])).to eq(false)
        end
        
        it 'should return true when frame contains 3 rolls with spare in first two ' do
            expect(BowlValidatorTestClass.validate_last_frame([5,5,10])).to eq(true)
        end
        it 'should return true when frame contains 3 rolls with no spare in first two ' do
            expect(BowlValidatorTestClass.validate_last_frame([1,4,0])).to eq(true)
        end
    end
end
