class AddProfileNameToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :profile_name, :string
  end
end
