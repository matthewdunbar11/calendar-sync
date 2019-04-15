class RenameEventDateFields < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :start_datetime, :start
    rename_column :events, :end_datetime, :end
  end
end
