class CreateDirections < ActiveRecord::Migration[7.0]
  def change
    create_table :directions do |t|
      t.text :description
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
