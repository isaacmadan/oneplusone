class AddPairSetIdToPair < ActiveRecord::Migration
  def change
    add_column :pairs, :pair_set_id, :integer
  end
end
