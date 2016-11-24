class OpenData < ApplicationRecord
  def self.search(search)
    where("CountryName LIKE ?", "%#{search}%")
  end
end
