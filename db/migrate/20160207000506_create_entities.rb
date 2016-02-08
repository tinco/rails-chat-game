class CreateEntities < ActiveRecord::Migration[5.0]
  def change
    create_table :entities do |t|
      t.text :components
      t.text :values

      t.timestamps
    end
  end
end
