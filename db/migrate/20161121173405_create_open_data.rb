class CreateOpenData < ActiveRecord::Migration[5.0]
  def change
    create_table :open_data do |t|
      t.string :CountryName
      t.text :Description
      t.string :Unit
      t.string :Value

      t.timestamps
    end
  end
end
