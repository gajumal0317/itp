class CreateRules < ActiveRecord::Migration[5.2]
  def change
    create_table :rules do |t|
      t.string :if_rule
      t.string :then_rule
      t.integer :master
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
