class CreateSocialOauths < ActiveRecord::Migration[5.1]
  def change
    create_table :social_oauths, options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci" do |t|
      t.references :user, null: false, index: true
      t.integer :provider, null: false, index: true
      t.string :uid, null: false, index: true
      t.string :screen_name
      t.string :access_token, null: false
      t.string :refresh_token
      t.datetime :expires_at
      t.timestamps
    end
  end
end
