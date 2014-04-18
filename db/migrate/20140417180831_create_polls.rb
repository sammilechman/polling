class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :title, uniq: true, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
