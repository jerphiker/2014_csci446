class CreatePets < ActiveRecord::Migration
#  def change
#    create_table :pets do |t|
#      t.string :petType
#      t.string :name
#      t.string :breed
#      t.text :description
#      t.string :image_url

#      t.timestamps
#    end
#  end
  def change
    rename_column :type, :petType, :string
  end
end
