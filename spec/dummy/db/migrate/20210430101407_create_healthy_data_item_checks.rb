class CreateHealthyDataItemChecks < ActiveRecord::Migration[6.1]
  def change
    create_table :healthy_data_item_checks do |t|
      t.datetime :checked_at
      t.references :checkable, polymorphic: true
      t.string :rule, index: true
      t.string :result
      t.boolean :solved, default: false
      t.json :args, default: {}

      t.timestamps
    end

    add_index :healthy_data_item_checks, [:checkable_type, :checkable_id],
      name: 'idx_healthy_data_item_checks_on_checkable'
  end
end
