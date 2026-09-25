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

ActiveRecord::Schema[8.1].define(version: 2026_09_24_183109) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgcrypto"

  create_table "blog_posts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "author_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.text "meta_description"
    t.string "meta_title"
    t.uuid "organization_id", null: false
    t.jsonb "schema_json"
    t.string "slug"
    t.string "status"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_blog_posts_on_author_id"
    t.index ["organization_id"], name: "index_blog_posts_on_organization_id"
    t.index ["slug"], name: "index_blog_posts_on_slug", unique: true
    t.index ["status"], name: "index_blog_posts_on_status"
  end

  create_table "blog_reviews", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "blog_post_id", null: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.integer "rating"
    t.datetime "updated_at", null: false
    t.uuid "user_id", null: false
    t.index ["blog_post_id"], name: "index_blog_reviews_on_blog_post_id"
    t.index ["user_id"], name: "index_blog_reviews_on_user_id"
  end

  create_table "crm_customers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "converted_user_id"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "lead_type", null: false
    t.text "notes"
    t.uuid "organization_id", null: false
    t.string "phone_country_code", null: false
    t.string "phone_number", null: false
    t.datetime "updated_at", null: false
    t.index ["converted_user_id"], name: "index_crm_customers_on_converted_user_id"
    t.index ["email"], name: "index_crm_customers_on_email"
    t.index ["first_name"], name: "index_crm_customers_on_first_name"
    t.index ["last_name"], name: "index_crm_customers_on_last_name"
    t.index ["lead_type"], name: "index_crm_customers_on_lead_type"
    t.index ["organization_id"], name: "index_crm_customers_on_organization_id"
    t.index ["phone_country_code"], name: "index_crm_customers_on_phone_country_code"
    t.index ["phone_number"], name: "index_crm_customers_on_phone_number"
  end

  create_table "deals", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "agent_buyer_id"
    t.uuid "agent_seller_id"
    t.uuid "client_id", null: false
    t.datetime "created_at", null: false
    t.string "deal_type", null: false
    t.uuid "organization_id"
    t.string "status", null: false
    t.datetime "updated_at", null: false
    t.uuid "vehicle_id", null: false
    t.index ["agent_buyer_id"], name: "index_deals_on_agent_buyer_id"
    t.index ["agent_seller_id"], name: "index_deals_on_agent_seller_id"
    t.index ["client_id"], name: "index_deals_on_client_id"
    t.index ["deal_type"], name: "index_deals_on_deal_type"
    t.index ["organization_id"], name: "index_deals_on_organization_id"
    t.index ["status"], name: "index_deals_on_status"
    t.index ["vehicle_id"], name: "index_deals_on_vehicle_id"
  end

  create_table "documents", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "file_url"
    t.boolean "is_public"
    t.uuid "organization_id", null: false
    t.boolean "read_only_image"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_documents_on_organization_id"
  end

  create_table "entity_features", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.uuid "featurable_id", null: false
    t.string "featurable_type", null: false
    t.uuid "feature_id", null: false
    t.datetime "updated_at", null: false
    t.index ["featurable_type", "featurable_id"], name: "index_entity_features_on_featurable"
    t.index ["feature_id"], name: "index_entity_features_on_feature_id"
  end

  create_table "event_requirements", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "approved_at"
    t.boolean "approved_by_user"
    t.decimal "cost_cents"
    t.datetime "created_at", null: false
    t.text "description"
    t.uuid "event_id", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_requirements_on_event_id"
  end

  create_table "events", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.boolean "custody_flag"
    t.string "event_type"
    t.uuid "organization_id", null: false
    t.decimal "price_cents"
    t.string "status"
    t.datetime "updated_at", null: false
    t.uuid "user_id", null: false
    t.uuid "vehicle_id", null: false
    t.index ["event_type"], name: "index_events_on_event_type"
    t.index ["organization_id"], name: "index_events_on_organization_id"
    t.index ["status"], name: "index_events_on_status"
    t.index ["user_id"], name: "index_events_on_user_id"
    t.index ["vehicle_id"], name: "index_events_on_vehicle_id"
  end

  create_table "families", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "family_members", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.uuid "family_id", null: false
    t.string "role"
    t.string "status"
    t.datetime "updated_at", null: false
    t.uuid "user_id", null: false
    t.index ["family_id"], name: "index_family_members_on_family_id"
    t.index ["user_id"], name: "index_family_members_on_user_id"
  end

  create_table "features", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "category"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.string "target_model"
    t.datetime "updated_at", null: false
  end

  create_table "notes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.uuid "notable_id", null: false
    t.string "notable_type", null: false
    t.uuid "organization_id", null: false
    t.string "privacy_level"
    t.datetime "updated_at", null: false
    t.uuid "user_id", null: false
    t.index ["notable_type", "notable_id"], name: "index_notes_on_notable"
    t.index ["organization_id"], name: "index_notes_on_organization_id"
    t.index ["privacy_level"], name: "index_notes_on_privacy_level"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "offers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "amount_cents", null: false
    t.datetime "created_at", null: false
    t.uuid "deal_id", null: false
    t.uuid "offeror_user_id", null: false
    t.uuid "organization_id"
    t.string "status", null: false
    t.datetime "updated_at", null: false
    t.index ["amount_cents"], name: "index_offers_on_amount_cents"
    t.index ["deal_id"], name: "index_offers_on_deal_id"
    t.index ["offeror_user_id"], name: "index_offers_on_offeror_user_id"
    t.index ["organization_id"], name: "index_offers_on_organization_id"
    t.index ["status"], name: "index_offers_on_status"
  end

  create_table "organization_roles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.uuid "organization_id", null: false
    t.jsonb "permissions"
    t.string "role_name"
    t.datetime "updated_at", null: false
    t.uuid "user_id", null: false
    t.index ["organization_id"], name: "index_organization_roles_on_organization_id"
    t.index ["user_id"], name: "index_organization_roles_on_user_id"
  end

  create_table "organizations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "org_type"
    t.string "phone_country_code"
    t.string "phone_number"
    t.string "tax_id"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_organizations_on_email"
    t.index ["name"], name: "index_organizations_on_name"
    t.index ["org_type"], name: "index_organizations_on_org_type"
    t.index ["phone_number"], name: "index_organizations_on_phone_number"
    t.index ["tax_id"], name: "index_organizations_on_tax_id"
  end

  create_table "plans", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.jsonb "features_config"
    t.string "name"
    t.decimal "price_cents"
    t.string "target_type"
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "expires_at"
    t.uuid "plan_id", null: false
    t.string "status"
    t.uuid "subscribable_id", null: false
    t.string "subscribable_type", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_subscriptions_on_plan_id"
    t.index ["subscribable_type", "subscribable_id"], name: "index_subscriptions_on_subscribable"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.boolean "active", default: true
    t.string "city"
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.integer "global_role"
    t.string "id_number"
    t.string "id_type"
    t.string "last_name"
    t.string "phone_country_code"
    t.string "phone_number"
    t.string "provider"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "theme"
    t.string "uid"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["id_number", "id_type"], name: "idx_users_id_number_type", unique: true
    t.index ["id_number", "phone_number", "email"], name: "idx_users_search"
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "brand"
    t.string "chasis_id"
    t.string "color"
    t.datetime "created_at", null: false
    t.uuid "family_id", null: false
    t.string "model"
    t.string "motor_id"
    t.string "plate"
    t.datetime "updated_at", null: false
    t.uuid "user_id", null: false
    t.string "vehicle_type"
    t.string "year"
    t.index ["brand"], name: "index_vehicles_on_brand"
    t.index ["chasis_id"], name: "index_vehicles_on_chasis_id", unique: true
    t.index ["family_id"], name: "index_vehicles_on_family_id"
    t.index ["model"], name: "index_vehicles_on_model"
    t.index ["motor_id"], name: "index_vehicles_on_motor_id", unique: true
    t.index ["plate"], name: "index_vehicles_on_plate", unique: true
    t.index ["user_id"], name: "index_vehicles_on_user_id"
    t.index ["vehicle_type"], name: "index_vehicles_on_vehicle_type"
  end

  create_table "webauthn_credentials", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "external_id", null: false
    t.text "public_key", null: false
    t.bigint "sign_count", default: 0, null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id", null: false
    t.index ["external_id"], name: "index_webauthn_credentials_on_external_id", unique: true
    t.index ["user_id"], name: "index_webauthn_credentials_on_user_id"
  end

  add_foreign_key "blog_posts", "organizations"
  add_foreign_key "blog_posts", "users", column: "author_id"
  add_foreign_key "blog_reviews", "blog_posts"
  add_foreign_key "blog_reviews", "users"
  add_foreign_key "crm_customers", "organizations", on_delete: :cascade
  add_foreign_key "crm_customers", "users", column: "converted_user_id", on_delete: :nullify
  add_foreign_key "deals", "organizations", on_delete: :nullify
  add_foreign_key "deals", "users", column: "agent_buyer_id", on_delete: :nullify
  add_foreign_key "deals", "users", column: "agent_seller_id", on_delete: :nullify
  add_foreign_key "deals", "users", column: "client_id", on_delete: :restrict
  add_foreign_key "deals", "vehicles", on_delete: :restrict
  add_foreign_key "documents", "organizations"
  add_foreign_key "entity_features", "features"
  add_foreign_key "event_requirements", "events"
  add_foreign_key "events", "organizations"
  add_foreign_key "events", "users"
  add_foreign_key "events", "vehicles"
  add_foreign_key "family_members", "families"
  add_foreign_key "family_members", "users"
  add_foreign_key "notes", "organizations"
  add_foreign_key "notes", "users"
  add_foreign_key "offers", "deals", on_delete: :cascade
  add_foreign_key "offers", "organizations", on_delete: :nullify
  add_foreign_key "offers", "users", column: "offeror_user_id", on_delete: :restrict
  add_foreign_key "organization_roles", "organizations"
  add_foreign_key "organization_roles", "users"
  add_foreign_key "subscriptions", "plans"
  add_foreign_key "vehicles", "families"
  add_foreign_key "vehicles", "users"
  add_foreign_key "webauthn_credentials", "users"
end
