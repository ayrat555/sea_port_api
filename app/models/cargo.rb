class Cargo < ActiveRecord::Base
  validates :volume, :name, presence: true
  has_many :opening_locations, as: :portable

  def matches_capacity?(capacity)
    volume - volume * configus.volume_inaccuracy <= capacity
  end


  private

    def inaccuracy
      volume * configus.volume_inaccuracy
    end
end
