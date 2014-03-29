# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140324031145) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "members", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email_address"
    t.integer  "organization_id"
  end

  create_table "members_pairs", id: false, force: true do |t|
    t.integer "member_id"
    t.integer "pair_id"
  end

  add_index "members_pairs", ["member_id", "pair_id"], name: "index_members_pairs_on_member_id_and_pair_id", using: :btree
  add_index "members_pairs", ["pair_id"], name: "index_members_pairs_on_pair_id", using: :btree

  create_table "members_teams", id: false, force: true do |t|
    t.integer "member_id"
    t.integer "team_id"
  end

  add_index "members_teams", ["member_id", "team_id"], name: "index_members_teams_on_member_id_and_team_id", using: :btree
  add_index "members_teams", ["team_id"], name: "index_members_teams_on_team_id", using: :btree

  create_table "organizations", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "pair_sets", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pairs", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pair_set_id"
  end

  create_table "persons_teams", id: false, force: true do |t|
    t.integer "person_id"
    t.integer "team_id"
  end

  add_index "persons_teams", ["person_id", "team_id"], name: "index_persons_teams_on_person_id_and_team_id", using: :btree
  add_index "persons_teams", ["team_id"], name: "index_persons_teams_on_team_id", using: :btree

  create_table "teams", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
