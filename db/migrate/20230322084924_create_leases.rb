class CreateLeases < ActiveRecord::Migration[6.1]
    def change
      create_table :leases do |t|
        t.references :apartment, null: false, foreign_key: true
        t.references :tenant, null: false, foreign_key: true
        t.integer :rent
  
        t.timestamps
      end
    end
  end