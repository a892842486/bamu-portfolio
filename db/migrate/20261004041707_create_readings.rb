class CreateReadings < ActiveRecord::Migration[8.1]
  def change
    create_table :readings do |t|
      t.string :title
      t.text :content
      t.date :read_at

      t.timestamps
    end
  end
end
