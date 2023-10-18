class CreateImages < ActiveRecord::Migration[6.1]
  def change
    create_table :images do |t|
      t.references :aloha, null: false, foreign_key: true
      t.string :image

      t.timestamps
    end
  end
end
