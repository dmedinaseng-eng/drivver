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

ActiveRecord::Schema[8.1].define(version: 2026_09_16_222940) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "blog_posts", force: :cascade do |t|
    t.bigint "author_id", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.text "meta_description"
    t.string "meta_title"
    t.bigint "organization_id", null: false
    t.jsonb "schema_json"
    t.string "slug", null: false
    t.string "status", default: "draft", null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_blog_posts_on_author_id"
    t.index ["organization_id"], name: "index_blog_posts_on_organization_id"
    t.index ["slug"], name: "index_blog_posts_on_slug", unique: true
    t.index ["status"], name: "index_blog_posts_on_status"
  end

  create_table "blog_reviews", force: :cascade do |t|
    t.bigint "blog_post_id", null: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.integer "rating", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["blog_post_id"], name: "index_blog_reviews_on_blog_post_id"
    t.index ["rating"], name: "index_blog_reviews_on_rating"
    t.index ["user_id"], name: "index_blog_reviews_on_user_id"
  end

  create_table "crm_customers", force: :cascade do |t|
    t.bigint "converted_user_id"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "lead_type", null: false
    t.text "notes"
    t.bigint "organization_id", null: false
    t.string "phone_country_code", null: false
    t.string "phone_number", null: false
    t.datetime "updated_at", null: false
    t.index ["converted_user_id"], name: "index_crm_customers_on_converted_user_id"
    t.index ["organization_id"], name: "index_crm_customers_on_organization_id"
  end

  create_table "deals", force: :cascade do |t|
    t.bigint "agent_buyer_id"
    t.bigint "agent_seller_id"
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.string "deal_type", null: false
    t.bigint "organization_id"
    t.string "status", null: false
    t.datetime "updated_at", null: false
    t.bigint "vehicle_id", null: false
    t.index ["agent_buyer_id"], name: "index_deals_on_agent_buyer_id"
    t.index ["agent_seller_id"], name: "index_deals_on_agent_seller_id"
    t.index ["client_id"], name: "index_deals_on_client_id"
    t.index ["deal_type"], name: "index_deals_on_deal_type"
    t.index ["organization_id"], name: "index_deals_on_organization_id"
    t.index ["status"], name: "index_deals_on_status"
    t.index ["vehicle_id"], name: "index_deals_on_vehicle_id"
  end

  create_table "documents", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "file_url", null: false
    t.boolean "is_public", default: false, null: false
    t.bigint "organization_id", null: false
    t.boolean "read_only_image", default: false, null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["is_public"], name: "index_documents_on_is_public"
    t.index ["organization_id"], name: "index_documents_on_organization_id"
  end

  create_table "entity_features", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "featurable_id", null: false
    t.string "featurable_type", null: false
    t.bigint "feature_id", null: false
    t.datetime "updated_at", null: false
    t.index ["featurable_type", "featurable_id"], name: "index_entity_features_on_featurable"
    t.index ["feature_id"], name: "index_entity_features_on_feature_id"
  end

  create_table "event_requirements", force: :cascade do |t|
    t.datetime "approved_at"
    t.boolean "approved_by_user", default: false, null: false
    t.decimal "cost_cents"
    t.datetime "created_at", null: false
    t.text "description", null: false
    t.bigint "event_id", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_requirements_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.boolean "custody_flag", default: false, null: false
    t.string "event_type", null: false
    t.bigint "organization_id"
    t.decimal "price_cents", null: false
    t.string "status", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "vehicle_id", null: false
    t.index ["event_type"], name: "index_events_on_event_type"
    t.index ["organization_id"], name: "index_events_on_organization_id"
    t.index ["status"], name: "index_events_on_status"
    t.index ["user_id"], name: "index_events_on_user_id"
    t.index ["vehicle_id"], name: "index_events_on_vehicle_id"
  end

  create_table "families", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_families_on_name"
  end

  create_table "family_members", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "family_id", null: false
    t.string "role"
    t.string "status", default: "Pending", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["family_id"], name: "index_family_members_on_family_id"
    t.index ["user_id"], name: "index_family_members_on_user_id"
  end

  create_table "features", force: :cascade do |t|
    t.string "category"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name", null: false
    t.string "target_model", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_features_on_category"
    t.index ["name"], name: "index_features_on_name"
    t.index ["target_model"], name: "index_features_on_target_model"
  end

  create_table "notes", force: :cascade do |t|
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.bigint "notable_id", null: false
    t.string "notable_type", null: false
    t.bigint "organization_id"
    t.string "privacy_level", default: "private", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["notable_type", "notable_id"], name: "index_notes_on_notable"
    t.index ["organization_id"], name: "index_notes_on_organization_id"
    t.index ["privacy_level"], name: "index_notes_on_privacy_level"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "offers", force: :cascade do |t|
    t.decimal "amount_cents", null: false
    t.datetime "created_at", null: false
    t.bigint "deal_id", null: false
    t.bigint "offeror_user_id", null: false
    t.bigint "organization_id"
    t.string "status", null: false
    t.datetime "updated_at", null: false
    t.index ["deal_id"], name: "index_offers_on_deal_id"
    t.index ["offeror_user_id"], name: "index_offers_on_offeror_user_id"
    t.index ["organization_id"], name: "index_offers_on_organization_id"
  end

  create_table "organization_roles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "organization_id", null: false
    t.jsonb "permissions", null: false
    t.string "role_name", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["organization_id"], name: "index_organization_roles_on_organization_id"
    t.index ["user_id"], name: "index_organization_roles_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name", null: false
    t.string "org_type", null: false
    t.string "phone_country_code", null: false
    t.string "phone_number", null: false
    t.string "tax_id", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_organizations_on_name"
    t.index ["org_type"], name: "index_organizations_on_org_type"
    t.index ["tax_id"], name: "index_organizations_on_tax_id"
  end

  create_table "plans", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.jsonb "features_config"
    t.string "name", null: false
    t.decimal "price_cents", null: false
    t.string "target_type", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "expires_at"
    t.bigint "plan_id", null: false
    t.string "status", null: false
    t.bigint "subscribable_id", null: false
    t.string "subscribable_type", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_subscriptions_on_plan_id"
    t.index ["subscribable_type", "subscribable_id"], name: "index_subscriptions_on_subscribable"
  end

  create_table "users", force: :cascade do |t|
    t.boolean "active", default: false, null: false
    t.string "city", null: false
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", null: false
    t.integer "global_role", default: 0, null: false
    t.string "id_number", null: false
    t.string "id_type", null: false
    t.string "last_name", null: false
    t.string "phone_country_code", null: false
    t.string "phone_number", null: false
    t.string "provider"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "theme", default: "light", null: false
    t.string "uid"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["id_number", "id_type"], name: "idx_users_id_number_type", unique: true
    t.index ["id_number", "phone_number", "email"], name: "idx_users_search"
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "brand", null: false
    t.string "chasis_id", null: false
    t.string "color", null: false
    t.datetime "created_at", null: false
    t.bigint "family_id"
    t.string "model", null: false
    t.string "motor_id", null: false
    t.string "plate", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.string "vehicle_type", null: false
    t.string "year", null: false
    t.index ["brand", "model"], name: "index_vehicles_on_brand_and_model"
    t.index ["chasis_id"], name: "index_vehicles_on_chasis_id"
    t.index ["family_id"], name: "index_vehicles_on_family_id"
    t.index ["motor_id"], name: "index_vehicles_on_motor_id"
    t.index ["plate"], name: "index_vehicles_on_plate"
    t.index ["user_id"], name: "index_vehicles_on_user_id"
    t.index ["vehicle_type"], name: "index_vehicles_on_vehicle_type"
  end

  add_foreign_key "blog_posts", "organizations", on_delete: :cascade
  add_foreign_key "blog_posts", "users", column: "author_id", on_delete: :restrict
  add_foreign_key "blog_reviews", "blog_posts", on_delete: :cascade
  add_foreign_key "blog_reviews", "users", on_delete: :cascade
  add_foreign_key "crm_customers", "organizations", on_delete: :cascade
  add_foreign_key "crm_customers", "users", column: "converted_user_id", on_delete: :nullify
  add_foreign_key "deals", "organizations", on_delete: :nullify
  add_foreign_key "deals", "users", column: "agent_buyer_id", on_delete: :nullify
  add_foreign_key "deals", "users", column: "agent_seller_id", on_delete: :nullify
  add_foreign_key "deals", "users", column: "client_id", on_delete: :restrict
  add_foreign_key "deals", "vehicles", on_delete: :restrict
  add_foreign_key "documents", "organizations", on_delete: :cascade
  add_foreign_key "entity_features", "features", on_delete: :cascade
  add_foreign_key "event_requirements", "events", on_delete: :cascade
  add_foreign_key "events", "organizations", on_delete: :nullify
  add_foreign_key "events", "users", on_delete: :restrict
  add_foreign_key "events", "vehicles", on_delete: :cascade
  add_foreign_key "family_members", "families", on_delete: :cascade
  add_foreign_key "family_members", "users", on_delete: :cascade
  add_foreign_key "notes", "organizations", on_delete: :nullify
  add_foreign_key "notes", "users", on_delete: :cascade
  add_foreign_key "offers", "deals", on_delete: :cascade
  add_foreign_key "offers", "organizations", on_delete: :nullify
  add_foreign_key "offers", "users", column: "offeror_user_id", on_delete: :restrict
  add_foreign_key "organization_roles", "organizations", on_delete: :cascade
  add_foreign_key "organization_roles", "users", on_delete: :cascade
  add_foreign_key "subscriptions", "plans"
  add_foreign_key "vehicles", "families", on_delete: :nullify
  add_foreign_key "vehicles", "users", on_delete: :restrict
end
