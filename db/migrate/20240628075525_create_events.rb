class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :title
      t.string :banner
      t.text :description
      t.string :location
      t.integer :capacity
      t.datetime :date
      t.string :host

      t.timestamps
    end
  end
end
