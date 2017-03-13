class CreateChoiceQuestions < ActiveRecord::Migration
  def change
    create_table :choice_questions do |t|
      t.timestamps null: false
    end
  end
end
