class CreateAlternatives < ActiveRecord::Migration
  def change
    create_table :alternatives do |t|
      t.belongs_to :choice_question, index: true, foreign_key: true
      t.text :text
      t.boolean :correct
      t.text :explanation # Explains to the user why the alternative is wrong

      t.timestamps null: false
    end
  end
end
