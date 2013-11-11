class AddUserIdToCropYield < ActiveRecord::Migration
  def change
    add_column :crop_yields, :user_id, :integer
  end
end
