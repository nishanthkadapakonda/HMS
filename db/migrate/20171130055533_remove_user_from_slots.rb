class RemoveUserFromSlots < ActiveRecord::Migration[5.1]
  def change
    remove_reference :slots, :user, foreign_key: true
  end
end
