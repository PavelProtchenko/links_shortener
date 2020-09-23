class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.string :name, null: false
      t.string :domain
      t.string :url, null: false
      t.integer :clicks, default: 0, null: false

      t.timestamps
    end

    add_index :links, [:name, :domain], unique: true
  end
end
