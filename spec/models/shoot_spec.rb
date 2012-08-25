require 'spec_helper'

describe Shoot do
  describe 'goal?' do
    let(:shoot) {Shoot.new}
    subject {shoot.goal?}

    context 'when the same coordinates' do
      before do
        shoot.shoot_cord = [1,1]
        shoot.safe_cord = [1,1]
      end

      it {should be_true} 
    end

    context 'when coordinates different' do
      before do 
        shoot.shoot_cord = [1,1]
        shoot.safe_cord = [4,1]
      end

      it {should be_false}
    end
  end

end
