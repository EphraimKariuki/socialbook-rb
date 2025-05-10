class RenameMameToNameInUsers < ActiveRecord::Migration[8.0]
  def change
    rename_column :users, :mame, :name
  end
end
