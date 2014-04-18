class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false, uniq: true
      t.timestamps
    end
  end
end
