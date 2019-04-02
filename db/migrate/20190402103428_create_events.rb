class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.references :calendar, foreign_key: true

      t.timestamps
    end
  end
end
