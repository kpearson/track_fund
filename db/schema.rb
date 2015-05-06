ActiveRecord::Schema.define(version: 20150505041424) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pledges", force: :cascade do |t|
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.integer  "nbuilder_event_id"
    t.integer  "nbuilder_person_id"
    t.string   "name"
    t.boolean  "fulfilled",                                   default: false, null: false
    t.decimal  "amount",             precision: 10, scale: 2
  end

  create_table "tokens", force: :cascade do |t|
    t.string   "token"
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tokens", ["user_id"], name: "index_tokens_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "uid"
    t.string   "provider"
    t.string   "first_name"
    t.string   "gender"
    t.string   "last_name"
    t.string   "link"
    t.string   "locale"
    t.string   "name"
    t.string   "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "tokens", "users"
end
