class CountriesController < ApplicationController
  def index
    @countries = Hash.new
    OpenData.all.each do |data|
      @countries[data.CountryName] = data.id
    end

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
