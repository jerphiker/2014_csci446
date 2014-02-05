class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :type
      t.string :name
      t.string :breed
      t.text :description
      t.string :image_url

      t.timestamps
    end
  end
end
