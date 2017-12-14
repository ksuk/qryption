class CreateInformation < ActiveRecord::Migration[5.1]
  def change
    create_table :information, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci" do |t|
      t.integer :status, null: false, default: 10
      t.string :title, null: false
      t.text :body, null: false
      t.timestamps
    end
    add_index :information, :status
  end
end
