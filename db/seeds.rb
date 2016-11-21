# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

dataToCollect = [
  "Population, total",
  "Population growth (annual %)",
  "Surface area (sq. km)",
  "Population density (people per sq. km of land area)",
  "Poverty headcount ratio at national poverty lines (% of population)",
  "Life expectancy at birth, total (years)",
  "Fertility rate, total (births per woman)",
  "Mortality rate, under-5 (per 1,000 live births)",
  "Prevalence of HIV, total (% of population ages 15-49)",
  "Forest area (sq. km)",
  "Improved water source (% of population with access)",
  "Improved sanitation facilities (% of population with access)",
  "Urban population growth (annual %)",
  "CO2 emissions (metric tons per capita)",
  "GDP (current US$)",
  "Time required to start a business (days)",
  "Military expenditure (% of GDP)",
  "Mobile cellular subscriptions (per 100 people)",
  "Internet users (per 100 people)",
  "Net migration"
]

openDataFile = File.join(Rails.root, 'db', 'CountryProfile.csv')

CSV.foreach(openDataFile) do |record|

  # Skip record if we are not intrested in data
  dataDescription = record[2]
  unless dataToCollect.include?(dataDescription)
    next
  end

  # Skip record if data is empty
  latestData = record[7]
  if latestData == ".." || latestData.nil?
    next
  end

  countryName =  record[0]
  unit = record[4]

  # Get unit description without number
  unless unit.nil?
    unit = unit.split.first
  end

  # If record has all requirements, insert to database
  OpenData.create(CountryName: countryName, Description: dataDescription, Unit: unit, Value: latestData)

end
