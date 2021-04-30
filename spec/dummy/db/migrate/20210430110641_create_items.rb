class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :amount
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
