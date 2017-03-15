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

ActiveRecord::Schema.define(version: 20170315225354) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alternatives", force: :cascade do |t|
    t.integer  "choice_question_id"
    t.text     "text"
    t.boolean  "correct"
    t.text     "explanation"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["choice_question_id"], name: "index_alternatives_on_choice_question_id", using: :btree
  end

  create_table "answers", force: :cascade do |t|
    t.integer  "item_id",        null: false
    t.integer  "user_id",        null: false
    t.integer  "alternative_id", null: false
    t.boolean  "correct"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["alternative_id"], name: "index_answers_on_alternative_id", using: :btree
    t.index ["item_id", "user_id"], name: "index_answers_on_item_id_and_user_id", unique: true, using: :btree
    t.index ["item_id"], name: "index_answers_on_item_id", using: :btree
    t.index ["user_id"], name: "index_answers_on_user_id", using: :btree
  end

  create_table "choice_questions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "code_questions", force: :cascade do |t|
    t.text     "initial_code"
    t.text     "expected_answer", null: false
    t.string   "language",        null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "discussion_id"
    t.text     "text"
    t.integer  "upvotes"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["discussion_id"], name: "index_comments_on_discussion_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "slug"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "discussions", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "user_id"
    t.integer  "upvotes",    default: 0
    t.string   "title"
    t.text     "text"
    t.boolean  "resolved",   default: false
    t.string   "slug"
    t.boolean  "edited",     default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["item_id"], name: "index_discussions_on_item_id", using: :btree
    t.index ["user_id"], name: "index_discussions_on_user_id", using: :btree
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "items", force: :cascade do |t|
    t.integer  "lesson_id"
    t.string   "itemable_type"
    t.integer  "itemable_id"
    t.integer  "weight"
    t.string   "title"
    t.text     "description"
    t.integer  "difficulty",    default: 0
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["lesson_id", "weight"], name: "index_items_on_lesson_id_and_weight", unique: true, using: :btree
    t.index ["lesson_id"], name: "index_items_on_lesson_id", using: :btree
  end

  create_table "lessons", force: :cascade do |t|
    t.string   "name"
    t.integer  "course_id"
    t.integer  "weight"
    t.string   "slug"
    t.boolean  "free",       default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["course_id", "weight"], name: "index_lessons_on_course_id_and_weight", unique: true, using: :btree
    t.index ["course_id"], name: "index_lessons_on_course_id", using: :btree
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "notificable_type"
    t.integer  "notificable_id"
    t.boolean  "seen",             default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["user_id"], name: "index_notifications_on_user_id", using: :btree
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.date     "expires_at"
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_subscriptions_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                   default: "",    null: false
    t.string   "encrypted_password",      default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "gender"
    t.string   "phone"
    t.string   "facebook_link"
    t.string   "facebook_avatar"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "iugu_token"
    t.string   "iugu_customer_id"
    t.string   "iugu_subscription_id"
    t.boolean  "has_active_subscription", default: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "videos", force: :cascade do |t|
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "alternatives", "choice_questions"
  add_foreign_key "answers", "alternatives"
  add_foreign_key "answers", "items"
  add_foreign_key "answers", "users"
  add_foreign_key "comments", "discussions"
  add_foreign_key "comments", "users"
  add_foreign_key "discussions", "items"
  add_foreign_key "discussions", "users"
  add_foreign_key "items", "lessons"
  add_foreign_key "notifications", "users"
  add_foreign_key "subscriptions", "users"
end
