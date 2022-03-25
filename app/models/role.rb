class Role < ApplicationRecord
  has_many :people

  def self.billable 
    where(billable: true)
  end
end
