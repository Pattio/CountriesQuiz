# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

# Remove old records
OpenData.delete_all

dataToCollect = [
  "Population, total",
  "Population growth (annual %)",
  "Surface area (sq. km)",
  "Population density (people per sq. km of land area)",
  "Poverty headcount ratio at national poverty lines (% of population)",
  "Fertility rate, total (births per woman)",
  "Mortality rate, under-5 (per 1,000 live births)",
  "Prevalence of HIV, total (% of population ages 15-49)",
  "Forest area (sq. km)",
  "Improved water source (% of population with access)",
  "Improved sanitation facilities (% of population with access)",
  "Urban population growth (annual %)",
  "GDP (current US$)",
  "Time required to start a business (days)",
  "Military expenditure (% of GDP)",
  "Mobile cellular subscriptions (per 100 people)",
  "Internet users (per 100 people)",
]

exclude = [
  "World", "East Asia & Pacific", "Europe & Central Asia", "Latin America & Caribbean", "Middle East & North Africa", "North America", "South Asia", "Sub-Saharan Africa", "Low income", "Middle income", "Lower middle income", "Upper middle income", "Low & middle income", "High income", "Euro area", "OECD members", "Fragile and conflict affected situations", "American Samoa", "Bermuda", "American Samoa", "Angola", "Aruba", "Bermuda", "Cayman Islands", "Channel Islands", "Curacao", "Faroe Islands", "French Polynesia", "Greenland", "Guam", "Hong Kong SAR, China", "Isle of Man", "Macao SAR, China", "New Caledonia", "Northern Mariana Islands", "Puerto Rico", "Sint Maarten (Dutch part)", "St. Martin (French part)", "Timor-Leste", "Turks and Caicos Islands", "Virgin Islands (U.S.)", "West Bank and Gaza"
]

rename = {
  "Syrian Arab Republic" => "Syria",
  "Lao PDR" => "Laos",
  "Korea, Rep." => "South Korea",
  "Korea, Dem. People’s Rep." => "North Korea",
  "Congo, Rep." => "Republic of the Congo",
  "Congo, Dem. Rep." => "Democratic Republic of the Congo"
}

openDataFile = File.join(Rails.root, 'db', 'CountryProfile.csv')

CSV.foreach(openDataFile) do |record|

  # Skip overall summary
  countryName =  record[0]
  if exclude.include?(countryName)
    next
  end

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

  unit = record[4]

  # Get unit description without number
  unless unit.nil?
    unit = unit.split.first
  end

  # Rename country
  if rename.has_key? countryName
    countryName = rename[countryName]
  end

  # Simplify country name by removing everything after coma
  countryName = countryName.dup.gsub(/,.*/, '')

  # If record has all requirements, insert to database
  OpenData.create(CountryName: countryName, Description: dataDescription, Unit: unit, Value: latestData)

end
