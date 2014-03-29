class CreateMembersPairs < ActiveRecord::Migration
  def self.up
    create_table :members_pairs, :id => false do |t|
        t.references :member
        t.references :pair
    end
    add_index :members_pairs, [:member_id, :pair_id]
    add_index :members_pairs, :pair_id
  end

  def self.down
    drop_table :members_pairs
  end
end