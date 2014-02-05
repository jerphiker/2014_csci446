class RemoveTypeFromPets < ActiveRecord::Migration
  def change
    remove_column :pets, :type, :string
  end
end
