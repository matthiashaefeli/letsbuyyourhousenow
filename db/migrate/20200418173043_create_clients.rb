class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.string :last_name
      t.string :first_name
      t.text :address
      t.string :city
      t.integer :zip
      t.string :state
      t.integer :tel, limit: 8
      t.boolean :active, default: true
      t.text :comments
      t.integer :offer, limit: 8
      t.integer :price, limit: 8
      t.string :email
      t.string :status, default: 'New'

      t.timestamps
    end
  end
end
