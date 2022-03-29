class Role < ApplicationRecord
  has_many :people

  def self.billable 
    where(billable: true)
  end

  def self.managers
    where(title: "Manager")
  end

  def self.average_salaries_by_profession 
    Person.joins(:role).group("roles.title").average(:salary).map{ |k,v| [k,format('%.2f' % v.to_f)]}.to_h
  end
end
