class Person < ApplicationRecord
  belongs_to :role
  belongs_to :location
  def self.billable
    Person.joins(:role).merge(Role.billable)
  end
end
