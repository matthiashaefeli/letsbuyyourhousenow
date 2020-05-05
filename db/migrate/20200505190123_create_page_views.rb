class CreatePageViews < ActiveRecord::Migration[6.0]
  def change
    create_table :page_views do |t|
      t.string :title
      t.integer :count

      t.timestamps
    end
  end
end
