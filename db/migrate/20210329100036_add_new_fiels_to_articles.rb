class AddNewFielsToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :theme, :string #add_column is a command

  end
end
