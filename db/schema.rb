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

ActiveRecord::Schema.define(version: 20160302043713) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authorizations", force: :cascade do |t|
    t.string   "provider",                null: false
    t.string   "uid",        limit: 1000, null: false
    t.integer  "user_id",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authorizations", ["provider", "uid"], name: "index_authorizations_on_provider_and_uid", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "body",             null: false
    t.text     "body_html"
    t.integer  "user_id",          null: false
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "devices", force: :cascade do |t|
    t.integer  "platform",        null: false
    t.integer  "user_id",         null: false
    t.string   "token",           null: false
    t.datetime "last_actived_at"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "devices", ["user_id", "platform"], name: "index_devices_on_user_id_and_platform", using: :btree
  add_index "devices", ["user_id"], name: "index_devices_on_user_id", using: :btree

  create_table "exception_logs", force: :cascade do |t|
    t.string   "title",      null: false
    t.text     "body",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name",                    null: false
    t.integer  "users_count", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locations", ["name"], name: "index_locations_on_name", using: :btree

  create_table "nodes", force: :cascade do |t|
    t.string   "name",                     null: false
    t.string   "summary"
    t.integer  "section_id",               null: false
    t.integer  "sort",         default: 0, null: false
    t.integer  "topics_count", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nodes", ["section_id"], name: "index_nodes_on_section_id", using: :btree
  add_index "nodes", ["sort"], name: "index_nodes_on_sort", using: :btree

  create_table "notes", force: :cascade do |t|
    t.string   "title",                         null: false
    t.text     "body",                          null: false
    t.integer  "user_id",                       null: false
    t.integer  "word_count",    default: 0,     null: false
    t.integer  "changes_count", default: 0,     null: false
    t.boolean  "publish",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notes", ["user_id"], name: "index_notes_on_user_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id",                            null: false
    t.boolean  "read",               default: false
    t.string   "type"
    t.integer  "follower_id"
    t.integer  "node_id"
    t.integer  "topic_id"
    t.integer  "reply_id"
    t.integer  "mentionable_id"
    t.string   "mentionable_type"
    t.integer  "mentioned_user_ids", default: [],                 array: true
    t.integer  "changes_count",      default: 0,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["user_id", "read"], name: "index_notifications_on_user_id_and_read", using: :btree
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id",           null: false
    t.integer  "application_id",              null: false
    t.string   "token",                       null: false
    t.integer  "expires_in",        limit: 8
    t.text     "redirect_uri",                null: false
    t.datetime "created_at",                  null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",                       null: false
    t.string   "refresh_token"
    t.integer  "expires_in",        limit: 8
    t.datetime "revoked_at"
    t.datetime "created_at",                  null: false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "uid",                       null: false
    t.string   "secret",                    null: false
    t.text     "redirect_uri",              null: false
    t.string   "scopes",       default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
    t.string   "owner_type"
  end

  add_index "oauth_applications", ["owner_id", "owner_type"], name: "index_oauth_applications_on_owner_id_and_owner_type", using: :btree
  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "page_versions", force: :cascade do |t|
    t.integer  "user_id",                null: false
    t.integer  "page_id",                null: false
    t.integer  "version",    default: 0, null: false
    t.string   "slug",                   null: false
    t.string   "title",                  null: false
    t.text     "desc",                   null: false
    t.text     "body",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "page_versions", ["page_id", "version"], name: "index_page_versions_on_page_id_and_version", using: :btree
  add_index "page_versions", ["page_id"], name: "index_page_versions_on_page_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.string   "slug",                           null: false
    t.string   "title",                          null: false
    t.text     "body",                           null: false
    t.text     "body_html"
    t.boolean  "locked",         default: false
    t.integer  "version",        default: 0,     null: false
    t.integer  "editor_ids",     default: [],    null: false, array: true
    t.integer  "word_count",     default: 0,     null: false
    t.integer  "changes_cout",   default: 1,     null: false
    t.integer  "comments_count", default: 0,     null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["slug"], name: "index_pages_on_slug", unique: true, using: :btree

  create_table "photos", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "image",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["user_id"], name: "index_photos_on_user_id", using: :btree

  create_table "replies", force: :cascade do |t|
    t.integer  "user_id",                         null: false
    t.integer  "topic_id",                        null: false
    t.text     "body",                            null: false
    t.text     "body_html"
    t.integer  "state",              default: 1,  null: false
    t.integer  "liked_user_ids",     default: [],              array: true
    t.integer  "likes_count",        default: 0
    t.integer  "mentioned_user_ids", default: [],              array: true
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "replies", ["topic_id"], name: "index_replies_on_topic_id", using: :btree
  add_index "replies", ["user_id"], name: "index_replies_on_user_id", using: :btree

  create_table "sections", force: :cascade do |t|
    t.string   "name",                   null: false
    t.integer  "sort",       default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sections", ["sort"], name: "index_sections_on_sort", using: :btree

  create_table "settings", force: :cascade do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree

  create_table "site_nodes", force: :cascade do |t|
    t.string   "name",                   null: false
    t.integer  "sort",       default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "site_nodes", ["sort"], name: "index_site_nodes_on_sort", using: :btree

  create_table "sites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "site_node_id"
    t.string   "name",         null: false
    t.string   "url",          null: false
    t.string   "desc"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sites", ["site_node_id"], name: "index_sites_on_site_node_id", using: :btree
  add_index "sites", ["url"], name: "index_sites_on_url", using: :btree

  create_table "topics", force: :cascade do |t|
    t.integer  "user_id",                               null: false
    t.integer  "node_id",                               null: false
    t.string   "title",                                 null: false
    t.text     "body",                                  null: false
    t.text     "body_html"
    t.integer  "last_reply_id"
    t.integer  "last_reply_user_id"
    t.string   "last_reply_user_login"
    t.string   "node_name"
    t.string   "who_deleted"
    t.integer  "last_active_mark"
    t.boolean  "lock_node",             default: false
    t.datetime "suggested_at"
    t.integer  "excellent",             default: 0
    t.datetime "replied_at"
    t.integer  "replies_count",         default: 0,     null: false
    t.integer  "likes_count",           default: 0
    t.integer  "follower_ids",          default: [],                 array: true
    t.integer  "liked_user_ids",        default: [],                 array: true
    t.integer  "mentioned_user_ids",    default: [],                 array: true
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topics", ["excellent"], name: "index_topics_on_excellent", using: :btree
  add_index "topics", ["last_active_mark"], name: "index_topics_on_last_active_mark", using: :btree
  add_index "topics", ["likes_count"], name: "index_topics_on_likes_count", using: :btree
  add_index "topics", ["node_id"], name: "index_topics_on_node_id", using: :btree
  add_index "topics", ["suggested_at"], name: "index_topics_on_suggested_at", using: :btree
  add_index "topics", ["user_id"], name: "index_topics_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "login",                                  null: false
    t.string   "name"
    t.string   "email",                                  null: false
    t.string   "email_md5",                              null: false
    t.boolean  "email_public",           default: false, null: false
    t.string   "location"
    t.integer  "location_id"
    t.string   "bio"
    t.string   "website"
    t.string   "company"
    t.string   "github"
    t.string   "twitter"
    t.string   "qq"
    t.string   "avatar"
    t.boolean  "verified",               default: false, null: false
    t.boolean  "hr",                     default: false, null: false
    t.integer  "state",                  default: 1,     null: false
    t.string   "tagline"
    t.string   "co"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt",          default: "",    null: false
    t.string   "persistence_token",      default: "",    null: false
    t.string   "single_access_token",    default: "",    null: false
    t.string   "perishable_token",       default: "",    null: false
    t.integer  "topics_count",           default: 0,     null: false
    t.integer  "replies_count",          default: 0,     null: false
    t.string   "private_token"
    t.integer  "favorite_topic_ids",     default: [],                 array: true
    t.integer  "blocked_node_ids",       default: [],                 array: true
    t.integer  "blocked_user_ids",       default: [],                 array: true
    t.integer  "following_ids",          default: [],                 array: true
    t.integer  "follower_ids",           default: [],                 array: true
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["location"], name: "index_users_on_location", using: :btree
  add_index "users", ["login"], name: "index_users_on_login", using: :btree
  add_index "users", ["private_token"], name: "index_users_on_private_token", using: :btree

end
