class CountriesController < ApplicationController
  def index
    # @opendata = OpenData.group(:CountryName)
    # @opendata = OpenData.select('DISTINCT CountryName, id')
    @opendata = OpenData.select('distinct on (CountryName) *')
    if params[:search]
      @opendata = @opendata.search(params[:search])
    end
  end

  def show
    @country = OpenData.find(params[:id])
    @data = OpenData.where(CountryName: @country.CountryName)
  end

  def search
    @opendata = OpenData.search(params[:search]).group(:CountryName)
  end
end
