class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes, options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci" do |t|
      t.references :user, null: false, index: true
      t.references :item, polymorphic: true, null: false, index: true

      t.timestamps
    end
  end
end
