# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090823184648) do

  create_table "announcements", :force => true do |t|
    t.string   "announcement_url"
    t.integer  "initiative_id"
    t.integer  "summary"
    t.date     "announcement_date"
    t.integer  "num_exp"
    t.integer  "number"
    t.integer  "page"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "commisions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "commission_members", :force => true do |t|
    t.integer  "commision_id"
    t.integer  "parliamentarian_id"
    t.string   "position"
    t.string   "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "initiatives", :force => true do |t|
    t.string   "num_exp"
    t.string   "title"
    t.string   "initiative_type"
    t.string   "votings"
    t.integer  "parliamentarian_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.integer  "topic_id"
    t.string   "proposer"
    t.string   "recipient"
    t.date     "initiative_date"
    t.date     "session_date"
  end

  create_table "intervention_parliamentarians", :force => true do |t|
    t.integer  "intervention_id"
    t.integer  "parliamentarian_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "intervention_speakers", :force => true do |t|
    t.integer  "intervention_id"
    t.integer  "speaker_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interventions", :force => true do |t|
    t.string   "file_number"
    t.integer  "commision_id"
    t.string   "diary_number"
    t.string   "subject_number"
    t.string   "subject_title"
    t.string   "txt_url"
    t.text     "full_txt"
    t.string   "pdf_url"
    t.string   "videos"
    t.integer  "initiative_id"
    t.string   "subject_treated"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "session_date"
  end

  create_table "parliamentarians", :force => true do |t|
    t.string   "full_name"
    t.string   "photo"
    t.string   "profession"
    t.string   "languages"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "orig_id"
    t.integer  "party_id"
    t.boolean  "active",            :default => false
    t.integer  "substitution_id"
    t.integer  "substitutes_id"
    t.integer  "substituted_by_id"
    t.string   "degree"
  end

  create_table "parties", :force => true do |t|
    t.string   "group_name"
    t.string   "acronym"
    t.string   "sites"
    t.string   "name"
    t.string   "url"
    t.string   "logo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.integer  "parliamentarian_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "procedures", :force => true do |t|
    t.integer  "initiative_id"
    t.string   "title"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "procedure_date"
  end

  create_table "speakers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "taggable_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "topics", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", :force => true do |t|
    t.integer  "parliamentarian_id"
    t.integer  "speaker_id"
    t.string   "title"
    t.string   "video_url"
    t.string   "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
