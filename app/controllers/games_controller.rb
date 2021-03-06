class GamesController < ApplicationController
  before_filter :load_game, except: :create

  def create
    user = User.create(email: params[:email])
    dummy_user = User.create(email: 'computer@gamer.com')

    game = Game.new(player_a: user, player_b: dummy_user)

    if game.save
      render json: {game: {id: game.id, next_role: game.next_role}}
    else
      render json: {errors: game.errors}, status: :not_acceptable
    end
  end

  def shoot
    @judge.judge_shoot params[:x], params[:y], params[:role]
    result = {
      shoot: {goal: @judge.goal?},
      game: {ended: @game.ended?, winner: @game.winner}
    }
    render json: result
  end
  
  private
  def load_game
    errors = {}
    @game = Game.find(params[:id])
    errors[:game] = {ended: 'already ended'} if @game.ended
    errors[:game] = {role: 'invalid'} if @game.next_role != params[:role]
    
    if errors.empty?
      @judge = Judge.new(@game)
    else
      render json: {errors: errors}, status: :not_acceptable
      return false
    end
  end
end
