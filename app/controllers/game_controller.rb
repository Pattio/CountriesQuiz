class GameController < ApplicationController
  include GameHelper

  def index
    @question = generate_question
    @records = OpenData.where(Description: @question).order("RANDOM()").limit(4)
    @answer = @records.sample
  end

end
