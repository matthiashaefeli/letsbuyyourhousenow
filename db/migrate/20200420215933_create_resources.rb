class CreateResources < ActiveRecord::Migration[6.0]
  def change
    create_table :resources do |t|
      t.string :name
      t.text :url

      t.timestamps
    end
  end
end
