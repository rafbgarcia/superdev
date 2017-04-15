class RemoveDoneFromItem < ActiveRecord::Migration[5.0]
  def change
    remove_column :items, :done
  end
end
