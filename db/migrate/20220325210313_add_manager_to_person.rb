class AddManagerToPerson < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :manager_id, :integer, foreign_key: true
  end
end
