class DropLoginsTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :logins
  end
end
