require 'spec_helper'
require 'ruby-debug'

describe GamesController do
  describe 'create new game' do
    it 'should create user and virtual user' do
      lambda {
        post :create, email: 'some@user.com' 
      }.should change { User.count}.by(2)
      response.should be_success
    end

    it 'should return game id' do
      lambda{
        post :create, email: 'some@user.com' 
      }.should change {Game.count}.by(1)

      json = JSON.parse(response.body)
      json['game']['id'].should == Game.first.id.to_s
    end
  end

  describe 'take a shoot' do
    let(:game) {Fabricate(:game)}

    it 'shoot should take a goal' do
      Judge.any_instance.stub(:random_cord).and_return([4,2])
      game.update_attribute(:next_role, 'shoot')

      lambda {
        post :shoot, id: game.id.to_s, x: 0, y: 0, role: 'shoot'
      }.should change {game.reload.series.size}.by(1)

      response.should be_success

      json = JSON.parse(response.body)
      json['shoot']['goal'].should be_true
      json['game']['ended'].should be_false
    end

    it 'not take a goal when shoot' do
      Judge.any_instance.stub(:random_cord).and_return([4,2])
      game.update_attribute(:next_role, 'shoot')

      post :shoot, id: game.id.to_s, x: 4, y: 2, role: 'shoot'
      response.should be_success
      json = JSON.parse(response.body)
      json['shoot']['goal'].should be_false
    end
  end

  describe 'lest play the game' do
    let(:game) {Fabricate(:game)}

    it 'should make 3 good goals and 3 good safe fourth shoot should win game' do
      game.update_attribute(:next_role, 'shoot')
      Judge.any_instance.stub(:random_cord).and_return([4,2])
      
      3.times{
        post :shoot, id: game.id.to_s, x: 0, y: 0, role: 'shoot'
        response.should be_success

        post :shoot, id: game.id.to_s, x: 4, y: 2, role: 'safe'
        response.should be_success
      }
      game.reload.series.size.should == 3
     

      post :shoot, id: game.id.to_s, x: 0, y: 0, role: 'shoot'
      
      response.should be_success
      json = JSON.parse(response.body)
      json['game']['ended'].should be_true
    end
  end
end
