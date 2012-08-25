require 'spec_helper'

describe Judge do
  let(:judge) { Judge.new(Fabricate(:game))}
  let(:game) { judge.game}

  context 'when shoot' do
    before {judge.judge_shoot(1,1, 'shoot')}
     
    it 'should create one serie' do
      game.series.size.should == 1
    end
    it 'should not complete serie' do 
      game.series.first.complete.should be_false
    end
  end

  context 'when almost won' do
    before do
      4.times do
        game.series << Fabricate.build(:series)
      end

      judge.judge_shoot(1,1, 'shoot')
    end

    it 'should win the game' do
      game.ended.should be_true
      game.winner == game.player_a
    end
  end

end
