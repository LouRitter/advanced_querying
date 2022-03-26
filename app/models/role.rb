class Role < ApplicationRecord
  has_many :people

  def self.billable 
    where(billable: true)
  end

  def self.managers
    where(title: "Manager")
  end
end
