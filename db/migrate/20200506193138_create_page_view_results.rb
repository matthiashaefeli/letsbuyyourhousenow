class CreatePageViewResults < ActiveRecord::Migration[6.0]
  def change
    create_table :page_view_results do |t|
      t.date :day
      t.string :title
      t.integer :count

      t.timestamps
    end
  end
end
