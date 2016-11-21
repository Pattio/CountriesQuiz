module GameHelper

  @@questionCategories = [
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
    "Internet users (per 100 people)"
  ]

  def generate_question
    @@questionCategories.sample
  end
end
