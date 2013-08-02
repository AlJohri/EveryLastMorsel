class CreateJoinTablePlotUser < ActiveRecord::Migration
  def change
	create_table :plots_users do |t|
  		t.belongs_to :user
  		t.belongs_to :plot
  	end
	# add_index :plots_users, [:plot_id, :user_id], :unique => true
  end
end