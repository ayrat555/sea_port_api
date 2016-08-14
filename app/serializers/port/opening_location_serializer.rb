class Port::OpeningLocationSerializer < BaseSerializer
  attributes :id, :first_date, :last_date
  belongs_to :portable
  belongs_to :port
end
