class AddIndexToSocialOauth < ActiveRecord::Migration[5.1]
  def change
    add_index :social_oauths, [:provider, :uid], unique: true
  end
end
