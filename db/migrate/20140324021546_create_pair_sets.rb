class CreatePairSets < ActiveRecord::Migration
  def change
    create_table :pair_sets do |t|

      t.timestamps
    end
  end
end
