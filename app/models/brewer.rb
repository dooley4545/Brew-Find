class Brewer < ActiveRecord::Base
  belongs_to :user
  has_many :beers

  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
end
