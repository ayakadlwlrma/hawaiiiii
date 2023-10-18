class CreateAlohas < ActiveRecord::Migration[6.1]
  def change
    create_table :alohas do |t|
      t.string :name
      t.string :time
      t.string :category
      t.string :about
      t.string :price
      t.text :link
      t.string :parking
      t.text :point
      t.integer :user_id
      t.string :photo
      t.float :lat
      t.float :lng
      t.text :address
      t.string :phonenumber

      t.timestamps
    end
  end
end
