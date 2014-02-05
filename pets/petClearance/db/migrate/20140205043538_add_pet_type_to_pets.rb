class AddPetTypeToPets < ActiveRecord::Migration
  def change
    add_column :pets, :petType, :string
  end
end
