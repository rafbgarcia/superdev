class CreateCodeQuestions < ActiveRecord::Migration
  def change
    create_table :code_questions do |t|
      t.text :initial_code
      t.text :expected_answer, null: false
      t.string :language, null: false

      t.timestamps null: false
    end
  end
end
