class CountriesController < ApplicationController
  def index
    @countries = Hash.new
    if params[:search]
      OpenData.search(params[:search]).each do |result|
        @countries[result.CountryName] = result.id
      end
    else
      OpenData.all.each do |data|
        @countries[data.CountryName] = data.id
      end
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
