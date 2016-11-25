class OpenData < ApplicationRecord
  def self.search(search)
    where("LOWER(\"CountryName\") LIKE ?", "%#{search.downcase}%")
  end
end
