require 'spec_helper'
require 'ruby-debug'

describe Series do 
  describe 'complete checking' do
    let(:serie) {Series.new(:game => Fabricate.build(:game))}
    subject {serie.complete}

    context 'when noone shooted' do
      it {should be_false}
    end
    
    context 'when one shooted' do
      before do
        serie.a_shooted = true
        serie.save
      end
      it {should be_false}

      context 'when also second shooted' do
        before { 
          serie.a_shooted = true
          serie.b_shooted = true
          serie.save 
        }
        it {should be_true}
      end
    end

  end
end
