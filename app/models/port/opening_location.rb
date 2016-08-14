class Port::OpeningLocation < ActiveRecord::Base
  validates :port, :first_date, :last_date, presence: true
  belongs_to :portable, polymorphic: true
  belongs_to :port
  scope :ships, -> port_id { where(port_id: port_id, portable_type: 'Ship') }
  scope :cargos, -> port_id { where(port_id: port_id, portable_type: 'Cargo') }

  def matches_date?(f_date, l_date)
    first_date <= f_date && last_date >= l_date
  end

  def cargo?
    portable_type == 'Cargo'
  end

  def ship?
    portable_type == 'Ship'
  end
end
