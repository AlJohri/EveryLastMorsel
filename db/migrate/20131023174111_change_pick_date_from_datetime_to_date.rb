class ChangePickDateFromDatetimeToDate < ActiveRecord::Migration
  def up
    change_column :crop_yields, :pick_date, :date
  end
  
  def down
    change_column :crop_yields, :pick_date, :datetime
  end
end
