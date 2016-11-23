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
    # TODO: Sanitize user guess
    @guessID = params[:country_id]
    @answerID = game_session.Answer.to_s

    respond_to do |format|
      if @guessID == @answerID

        @question = generate_question
        @records = OpenData.where(Description: @question).order("RANDOM()").limit(4)
        @answer = @records.sample
        @score = game_session.Score
        @score += 50
        @highscore = current_user.highscore
        @totalPlays = current_user.totalPlays + 1
        current_user.update_attributes(totalPlays: @totalPlays)

        if @highscore < @score
          @highscore = @score
          current_user.update_attributes(highscore: @highscore)
        end

        options = String.new
        @records.each do |record|
          options << record.id.to_s
          options << "|" if @records.last != record
        end
        game_session.update_attributes(Question: @question, Score: @score, Answer: @answer.id, Options: options)

        format.html { redirect_to root_path }
        format.js { }
      else
        current_user.game_session = nil
        format.html { redirect_to root_path }
        format.js { }
        # format.js { render :js => 'window.location.replace("http://stackoverflow.com");' }
      end
    end
  end

end
