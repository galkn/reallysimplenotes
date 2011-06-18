class RenameNameToEmailInUsers < ActiveRecord::Migration
  def self.up
    rename_column :users, :name, :email
  end

  def self.down
  end
end
