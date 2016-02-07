class CreateEntities < ActiveRecord::Migration[5.0]
  def change
    create_table :entities, id: false do |t|
      t.string :id
      t.text :components
      t.text :values

      t.timestamps
    end
    add_index :entities, :id, unique: true
  end
end
