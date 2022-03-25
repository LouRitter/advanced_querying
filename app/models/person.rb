class Person < ApplicationRecord
  belongs_to :role

  def self.billable
    Person.joins(:role).merge(Role.billable)
  end
end
