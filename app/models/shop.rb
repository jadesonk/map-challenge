class Shop < ApplicationRecord
  geocoded_by :address

  validates :name, :address, :category, presence: true
  after_validation :geocode, if: :will_save_change_to_address?

  enum category: {
    not_set: "not_set",
    spa_and_massage: "spa_and_massage",
    nails: "nails",
    hair_removal: "hair_removal",
    barbershop: "barbershop"
  }

  def self.filter_by_category category
    Shop.where.not(latitude: nil, longitude: nil).where(category: category)
  end
end
