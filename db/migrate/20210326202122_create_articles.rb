class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t| #create fiels is a command
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
