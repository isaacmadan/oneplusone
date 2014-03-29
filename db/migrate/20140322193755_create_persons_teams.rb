class CreatePersonsTeams < ActiveRecord::Migration
  def self.up
    create_table :persons_teams, :id => false do |t|
        t.references :person
        t.references :team
    end
    add_index :persons_teams, [:person_id, :team_id]
    add_index :persons_teams, :team_id
  end

  def self.down
    drop_table :persons_teams
  end
end