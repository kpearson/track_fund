ActiveRecord::Schema.define(version: 20150425181737) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

end
