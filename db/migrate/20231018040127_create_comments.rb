class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :aloha_id
      t.string :star

      t.timestamps
    end
  end
end
