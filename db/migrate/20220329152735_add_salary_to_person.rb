class AddSalaryToPerson < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :salary, :integer, null: false

  end
end
