class Ship < ActiveRecord::Base
  validates :name, :hold_capacity, presence: true
  has_many :opening_locations, as: :portable

  def matches_volume?(volume)
    hold_capacity + inaccuracy  >= volume
  end

  private

    def inaccuracy
      hold_capacity * configus.volume_inaccuracy
    end
end
