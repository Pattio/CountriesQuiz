class GameController < ApplicationController
  include GameHelper

  @answer = nil

  def index
    @question = generate_question
    @records = OpenData.where(Description: @question).order("RANDOM()").limit(4)
    @answer = @records.sample
  end

  def guess
    guessID = params[:country_id]
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { }
    end
  end

end
