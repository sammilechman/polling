class CreateAnswerChoices < ActiveRecord::Migration
  def change
    create_table :answer_choices do |t|
      t.string :text, :null => :false
      t.integer :question_id, :null => :false
      t.timestamps
    end
  end
end
