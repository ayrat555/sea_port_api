class Port < ActiveRecord::Base
  validates :title, :lat, :lng, presence: true
  geocoded_by :title, :latitude  => :lat, :longitude => :lng
end
