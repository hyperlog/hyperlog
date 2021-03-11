# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_11_050026) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "githubs", primary_key: "uid", force: :cascade do |t|
    t.bigint "profile_id"
    t.string "access_token", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "user_profile"
    t.index ["profile_id"], name: "index_githubs_on_profile_id", unique: true
  end

  create_table "profile_repo_analyses", force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.uuid "repo_id", null: false
    t.uuid "project_id"
    t.integer "contributions"
    t.jsonb "tech_analysis"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["profile_id", "repo_id"], name: "index_profile_repo_analyses_on_profile_id_and_repo_id", unique: true
    t.index ["profile_id"], name: "index_profile_repo_analyses_on_profile_id"
    t.index ["project_id"], name: "index_profile_repo_analyses_on_project_id"
    t.index ["repo_id"], name: "index_profile_repo_analyses_on_repo_id"
    t.index ["tech_analysis"], name: "index_profile_repo_analyses_on_tech_analysis", using: :gin
  end

  create_table "profiles", force: :cascade do |t|
    t.uuid "user_id"
    t.string "about", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "tagline", default: "", null: false
    t.jsonb "social_links", default: {}, null: false
    t.jsonb "analysis_status"
    t.integer "theme", default: 0
    t.index ["user_id"], name: "index_profiles_on_user_id", unique: true
  end

  create_table "projects", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.string "name", null: false
    t.string "tagline", null: false
    t.string "description", null: false
    t.string "image_url", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "aggregated_tech_analysis"
    t.index ["profile_id"], name: "index_projects_on_profile_id"
  end

  create_table "repos", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "provider", null: false
    t.bigint "provider_repo_id", null: false
    t.string "full_name", null: false
    t.string "avatar_url"
    t.text "description"
    t.boolean "is_private"
    t.string "primary_language"
    t.integer "stargazers"
    t.string "image_url"
    t.jsonb "analysis"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["full_name"], name: "index_repos_on_full_name"
    t.index ["provider_repo_id", "provider"], name: "index_repos_on_provider_repo_id_and_provider", unique: true
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "provider"
    t.string "uid"
    t.string "username"
    t.boolean "username_confirmed"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "githubs", "profiles"
  add_foreign_key "profile_repo_analyses", "profiles"
  add_foreign_key "profile_repo_analyses", "projects"
  add_foreign_key "profile_repo_analyses", "repos"
  add_foreign_key "profiles", "users"
  add_foreign_key "projects", "profiles"
end
