class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.string :name
      t.integer :age
      t.references :role, foreign_key: true

      t.timestamps
    end
  end
end
