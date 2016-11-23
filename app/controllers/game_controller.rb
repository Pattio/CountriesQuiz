class GameController < ApplicationController
  before_action :authenticate_user!

  include GameHelper

  def index

    if user_signed_in? == false
      redirect_to new_user_session_path
    end
    game_session = current_user.game_session

    if game_session == nil
      @question = generate_question
      @records = OpenData.where(Description: @question).order("RANDOM()").limit(4)
      @answer = @records.sample

      options = String.new
      @records.each do |record|
        options << record.id.to_s
        options << "|" if @records.last != record
      end
      current_user.create_game_session(Question: @question, Score: 0, Answer: @answer.id, Options: options)
    else
      @question = game_session.Question
      @answer = OpenData.find(game_session.Answer)
      options = game_session.Options
      countries = options.split("|").map(&:to_i)
      @records = Array.new
      countries.each do |country|
        @records << OpenData.find(country)
      end
    end

  end

  def guess
    game_session = current_user.game_session
    guessID = params[:country_id]

    respond_to do |format|
      if guessID == game_session.Answer.to_s

        @question = generate_question
        @records = OpenData.where(Description: @question).order("RANDOM()").limit(4)
        @answer = @records.sample
        @score = game_session.Score
        @score += 50
        @highscore = current_user.highscore

        if @highscore < @score
          current_user.update_attributes(highscore: @score)
        end

        options = String.new
        @records.each do |record|
          options << record.id.to_s
          options << "|" if @records.last != record
        end
        current_user.game_session.update_attributes(Question: @question, Score: @score, Answer: @answer.id, Options: options)

        @response = "Correct"
        format.html { redirect_to root_path }
        format.js { }
      else
        @response = "Incorrect"
        format.html { redirect_to root_path }
        format.js { }
      end
    end
  end

end
