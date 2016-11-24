class CountriesController < ApplicationController
  def index
    @opendata = OpenData.group(:CountryName)
  end

  def show
    @country = OpenData.find(params[:id])
    @data = OpenData.where(CountryName: @country.CountryName)
  end
end
