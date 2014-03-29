class CreateMembersTeams < ActiveRecord::Migration
  def self.up
    create_table :members_teams, :id => false do |t|
        t.references :member
        t.references :team
    end
    add_index :members_teams, [:member_id, :team_id]
    add_index :members_teams, :team_id
  end

  def self.down
    drop_table :members_teams
  end
end