class AddTokenToNotes < ActiveRecord::Migration
  def self.up
    add_column :notes, :token, :string
  end

  def self.down
    remove_column :notes, :token
  end
end
