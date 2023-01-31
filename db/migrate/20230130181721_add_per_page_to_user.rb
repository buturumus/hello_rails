class AddPerPageToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :per_page, :integer, default: 10
  end
end
