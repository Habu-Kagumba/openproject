class CreateShares < ActiveRecord::Migration[7.1]
  def change
    create_table :shares do |t|
      t.references :parent, null: false, foreign_key: { to_table: :companies }
      t.references :child, null: false, foreign_key: { to_table: :companies }
      t.boolean :active, null: false, default: true

      t.timestamps
    end
  end
end
