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

ActiveRecord::Schema[7.1].define(version: 0) do
  create_schema "global"
  create_schema "single"

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_cards", id: :serial, force: :cascade do |t|
    t.string "code", null: false
    t.string "status", null: false
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
    t.datetime "modified", precision: nil, default: -> { "now()" }, null: false
    t.integer "modified_by"

    t.unique_constraint ["code"], name: "UN_access_cards"
  end

  create_table "access_control", id: :serial, force: :cascade do |t|
    t.integer "access_card_id", null: false
    t.integer "user_id", null: false
    t.datetime "arrival_time", precision: nil, default: -> { "now()" }, null: false
    t.datetime "departure_time", precision: nil
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
    t.datetime "modified", precision: nil, default: -> { "now()" }, null: false
    t.integer "modified_by"
    t.index ["access_card_id"], name: "FKI_access_control_access_cards"
    t.index ["departure_time", "user_id"], name: "ix_access_control_departure_time_user_id"
    t.index ["user_id"], name: "FKI_access_control_users"
  end

  create_table "authorities_brief_formats", primary_key: "datafield", id: { type: :string, limit: 3 }, force: :cascade do |t|
    t.text "format", null: false
    t.integer "sort_order"
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
    t.datetime "modified", precision: nil, default: -> { "now()" }, null: false
    t.integer "modified_by"
  end

  create_table "authorities_form_datafields", primary_key: "datafield", id: { type: :string, limit: 3 }, force: :cascade do |t|
    t.boolean "collapsed", default: false, null: false
    t.boolean "repeatable", default: false, null: false
    t.string "indicator_1"
    t.string "indicator_2"
    t.string "material_type"
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
    t.datetime "modified", precision: nil, default: -> { "now()" }, null: false
    t.integer "modified_by"
    t.integer "sort_order"
  end

  create_table "authorities_form_subfields", primary_key: ["datafield", "subfield"], force: :cascade do |t|
    t.string "datafield", limit: 3, null: false
    t.string "subfield", limit: 1, null: false
    t.boolean "collapsed", default: false, null: false
    t.boolean "repeatable", default: false, null: false
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
    t.datetime "modified", precision: nil, default: -> { "now()" }, null: false
    t.integer "modified_by"
    t.string "autocomplete_type", default: "disabled", null: false
    t.integer "sort_order"
  end

  create_table "authorities_idx_autocomplete", id: :serial, force: :cascade do |t|
    t.string "datafield", limit: 3, null: false
    t.string "subfield", limit: 1, null: false
    t.string "word", null: false
    t.string "phrase", null: false
    t.integer "record_id"
    t.index ["datafield", "subfield", "word"], name: "IX_authorities_idx_autocomplete_word", opclass: { word: :varchar_pattern_ops }
    t.index ["record_id"], name: "IX_authorities_idx_autocomplete_record_id"
  end

  create_table "authorities_idx_fields", primary_key: ["record_id", "indexing_group_id", "word", "datafield"], force: :cascade do |t|
    t.integer "record_id", null: false
    t.integer "indexing_group_id", null: false
    t.string "word", null: false
    t.integer "datafield", null: false
    t.index ["word"], name: "IX_authorities_idx_fields_word", opclass: :varchar_pattern_ops
  end

  create_table "authorities_idx_sort", primary_key: ["record_id", "indexing_group_id"], force: :cascade do |t|
    t.integer "record_id", null: false
    t.integer "indexing_group_id", null: false
    t.string "phrase"
    t.integer "ignore_chars_count"
  end

  create_table "authorities_indexing_groups", id: :serial, force: :cascade do |t|
    t.string "translation_key", null: false
    t.text "datafields"
    t.boolean "sortable", default: false, null: false
    t.boolean "default_sort", default: false, null: false
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
    t.datetime "modified", precision: nil, default: -> { "now()" }, null: false
    t.integer "modified_by"
  end

  create_table "authorities_records", id: :serial, force: :cascade do |t|
    t.text "iso2709", null: false
    t.string "material", limit: 20
    t.string "database", limit: 10, default: "main", null: false
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
    t.datetime "modified", precision: nil, default: -> { "now()" }, null: false
    t.integer "modified_by"
  end

  create_table "authorities_search_results", primary_key: ["search_id", "indexing_group_id", "record_id"], force: :cascade do |t|
    t.integer "search_id", null: false
    t.integer "indexing_group_id", null: false
    t.integer "record_id", null: false
    t.index ["search_id", "record_id"], name: "IX_authorities_search_results"
  end

  create_table "authorities_searches", id: :serial, force: :cascade do |t|
    t.text "parameters", null: false
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
  end

  create_table "backups", id: :serial, force: :cascade do |t|
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.string "path"
    t.string "schemas", null: false
    t.string "type", null: false
    t.string "scope", null: false
    t.boolean "downloaded", default: false, null: false
    t.integer "steps"
    t.integer "current_step"
  end

  create_table "biblio_brief_formats", primary_key: "datafield", id: { type: :string, limit: 3 }, force: :cascade do |t|
    t.text "format", null: false
    t.integer "sort_order"
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
    t.datetime "modified", precision: nil, default: -> { "now()" }, null: false
    t.integer "modified_by"
  end

  create_table "biblio_form_datafields", primary_key: "datafield", id: { type: :string, limit: 3 }, force: :cascade do |t|
    t.boolean "collapsed", default: false, null: false
    t.boolean "repeatable", default: false, null: false
    t.string "indicator_1"
    t.string "indicator_2"
    t.string "material_type"
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
    t.datetime "modified", precision: nil, default: -> { "now()" }, null: false
    t.integer "modified_by"
    t.integer "sort_order"
  end

  create_table "biblio_form_subfields", primary_key: ["datafield", "subfield"], force: :cascade do |t|
    t.string "datafield", limit: 3, null: false
    t.string "subfield", limit: 1, null: false
    t.boolean "collapsed", default: false, null: false
    t.boolean "repeatable", default: false, null: false
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
    t.datetime "modified", precision: nil, default: -> { "now()" }, null: false
    t.integer "modified_by"
    t.string "autocomplete_type", default: "disabled", null: false
    t.integer "sort_order"
  end

  create_table "biblio_holdings", id: :serial, force: :cascade do |t|
    t.integer "record_id", null: false
    t.text "iso2709", null: false
    t.string "database", limit: 10, default: "main", null: false
    t.string "accession_number", null: false
    t.string "location_d"
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
    t.datetime "modified", precision: nil, default: -> { "now()" }, null: false
    t.integer "modified_by"
    t.string "material", limit: 20
    t.string "availability", default: "available", null: false
    t.boolean "label_printed", default: false
    t.index ["accession_number"], name: "IX_biblio_holdings_accession_number", unique: true
    t.index ["record_id", "database"], name: "IX_biblio_holdings_biblio_record"
    t.index ["record_id", "location_d"], name: "IX_biblio_holdings_location_d"
  end

  create_table "biblio_idx_autocomplete", id: :serial, force: :cascade do |t|
    t.string "datafield", limit: 3, null: false
    t.string "subfield", limit: 1, null: false
    t.string "word", null: false
    t.string "phrase", null: false
    t.integer "record_id"
    t.index ["datafield", "subfield", "word"], name: "IX_biblio_idx_autocomplete_word", opclass: { word: :varchar_pattern_ops }
    t.index ["record_id"], name: "IX_biblio_idx_autocomplete_record_id"
  end

  create_table "biblio_idx_fields", primary_key: ["record_id", "indexing_group_id", "word", "datafield"], force: :cascade do |t|
    t.integer "record_id", null: false
    t.integer "indexing_group_id", null: false
    t.string "word", null: false
    t.integer "datafield", null: false
    t.index ["word"], name: "IX_biblio_idx_fields_word", opclass: :varchar_pattern_ops
  end

  create_table "biblio_idx_sort", primary_key: ["record_id", "indexing_group_id"], force: :cascade do |t|
    t.integer "record_id", null: false
    t.integer "indexing_group_id", null: false
    t.string "phrase"
    t.integer "ignore_chars_count"
  end

  create_table "biblio_indexing_groups", id: :serial, force: :cascade do |t|
    t.string "translation_key", null: false
    t.text "datafields"
    t.boolean "sortable", default: false, null: false
    t.boolean "default_sort", default: false, null: false
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
    t.datetime "modified", precision: nil, default: -> { "now()" }, null: false
    t.integer "modified_by"
  end

  create_table "biblio_records", id: :serial, force: :cascade do |t|
    t.text "iso2709", null: false
    t.string "material", limit: 20
    t.string "database", limit: 10, default: "main", null: false
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
    t.datetime "modified", precision: nil, default: -> { "now()" }, null: false
    t.integer "modified_by"
  end

  create_table "biblio_search_results", primary_key: ["search_id", "indexing_group_id", "record_id"], force: :cascade do |t|
    t.integer "search_id", null: false
    t.integer "indexing_group_id", null: false
    t.integer "record_id", null: false
    t.index ["search_id", "record_id"], name: "IX_biblio_search_results"
  end

  create_table "biblio_searches", id: :serial, force: :cascade do |t|
    t.text "parameters", null: false
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
  end

  create_table "configurations", primary_key: "key", id: :string, force: :cascade do |t|
    t.string "value", null: false
    t.string "type", default: "string", null: false
    t.boolean "required", default: false, null: false
    t.datetime "modified", precision: nil, default: -> { "now()" }, null: false
    t.integer "modified_by"
  end

  create_table "digital_media", id: :serial, force: :cascade do |t|
    t.string "name"
    t.oid "blob", null: false
    t.string "content_type"
    t.bigint "size"
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
  end

  create_table "holding_creation_counter", id: :serial, force: :cascade do |t|
    t.string "user_name", limit: 255, null: false
    t.string "user_login", limit: 100
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by", null: false
  end

  create_table "holding_form_datafields", primary_key: "datafield", id: { type: :string, limit: 3 }, force: :cascade do |t|
    t.boolean "collapsed", default: false, null: false
    t.boolean "repeatable", default: false, null: false
    t.string "indicator_1"
    t.string "indicator_2"
    t.string "material_type"
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
    t.datetime "modified", precision: nil, default: -> { "now()" }, null: false
    t.integer "modified_by"
    t.integer "sort_order"
  end

  create_table "holding_form_subfields", primary_key: ["datafield", "subfield"], force: :cascade do |t|
    t.string "datafield", limit: 3, null: false
    t.string "subfield", limit: 1, null: false
    t.boolean "collapsed", default: false, null: false
    t.boolean "repeatable", default: false, null: false
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
    t.datetime "modified", precision: nil, default: -> { "now()" }, null: false
    t.integer "modified_by"
    t.string "autocomplete_type", default: "disabled", null: false
    t.integer "sort_order"
  end

  create_table "lending_fines", id: :serial, force: :cascade do |t|
    t.integer "lending_id", null: false
    t.integer "user_id", null: false
    t.float "fine_value", null: false
    t.datetime "payment_date", precision: nil
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
  end

  create_table "lendings", id: :serial, force: :cascade do |t|
    t.integer "holding_id", null: false
    t.integer "user_id", null: false
    t.integer "previous_lending_id"
    t.datetime "expected_return_date", precision: nil
    t.datetime "return_date", precision: nil
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
  end

  create_table "logins", id: :serial, force: :cascade do |t|
    t.string "login", null: false
    t.boolean "employee", default: false, null: false
    t.text "password", null: false
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
    t.datetime "modified", precision: nil, default: -> { "now()" }, null: false
    t.integer "modified_by"

    t.unique_constraint ["login"], name: "UN_logins"
  end

  create_table "orders", id: :serial, force: :cascade do |t|
    t.text "info"
    t.string "status"
    t.string "invoice_number"
    t.datetime "receipt_date", precision: nil, default: -> { "now()" }
    t.decimal "total_value"
    t.integer "delivered_quantity"
    t.string "terms_of_payment"
    t.datetime "deadline_date", precision: nil, default: -> { "now()" }, null: false
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
    t.datetime "modified", precision: nil, default: -> { "now()" }, null: false
    t.integer "modified_by"
    t.integer "quotation_id", null: false
  end

  create_table "permissions", primary_key: ["login_id", "permission"], force: :cascade do |t|
    t.integer "login_id", null: false
    t.string "permission", limit: 80, null: false
  end

  create_table "quotations", id: :serial, force: :cascade do |t|
    t.integer "supplier_id", null: false
    t.datetime "response_date", precision: nil
    t.datetime "expiration_date", precision: nil
    t.integer "delivery_time"
    t.text "info"
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
    t.datetime "modified", precision: nil, default: -> { "now()" }, null: false
    t.integer "modified_by"
  end

  create_table "request_quotation", primary_key: ["request_id", "quotation_id"], force: :cascade do |t|
    t.integer "request_id", null: false
    t.integer "quotation_id", null: false
    t.integer "quotation_quantity"
    t.decimal "unit_value"
    t.integer "response_quantity"
  end

  create_table "requests", id: :integer, default: -> { "nextval('request_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "requester"
    t.string "author"
    t.string "item_title"
    t.string "item_subtitle"
    t.string "edition_number"
    t.string "publisher"
    t.text "info"
    t.string "status"
    t.integer "quantity"
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
    t.datetime "modified", precision: nil, default: -> { "now()" }, null: false
    t.integer "modified_by"
  end

  create_table "reservations", id: :serial, force: :cascade do |t|
    t.integer "record_id", null: false
    t.integer "user_id", null: false
    t.datetime "expires", precision: nil
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
  end

  create_table "suppliers", id: :integer, default: -> { "nextval('supplier_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "trademark", null: false
    t.string "supplier_name"
    t.string "supplier_number", null: false
    t.string "vat_registration_number"
    t.string "address"
    t.string "address_number"
    t.string "address_complement"
    t.string "area"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "zip_code"
    t.string "telephone_1"
    t.string "telephone_2"
    t.string "telephone_3"
    t.string "telephone_4"
    t.string "contact_1"
    t.string "contact_2"
    t.string "contact_3"
    t.string "contact_4"
    t.string "info"
    t.string "url"
    t.string "email"
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
    t.datetime "modified", precision: nil, default: -> { "now()" }, null: false
    t.integer "modified_by"
  end

  create_table "translations", primary_key: ["language", "key"], force: :cascade do |t|
    t.string "language", null: false
    t.string "key", null: false
    t.text "text", null: false
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
    t.datetime "modified", precision: nil, default: -> { "now()" }, null: false
    t.integer "modified_by"
    t.boolean "user_created", default: false, null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.integer "type"
    t.string "photo_id"
    t.string "status", null: false
    t.integer "login_id"
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
    t.datetime "modified", precision: nil, default: -> { "now()" }, null: false
    t.integer "modified_by"
    t.boolean "user_card_printed", default: false
    t.string "name_ascii"
    t.index ["name"], name: "IX_users_name", opclass: :varchar_pattern_ops
  end

  create_table "users_fields", primary_key: "key", id: :string, force: :cascade do |t|
    t.string "type", null: false
    t.boolean "required", default: false, null: false
    t.integer "max_length", default: 0, null: false
    t.integer "sort_order"
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
    t.datetime "modified", precision: nil, default: -> { "now()" }, null: false
    t.integer "modified_by"
  end

  create_table "users_types", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.integer "lending_limit"
    t.integer "reservation_limit"
    t.integer "lending_time_limit"
    t.integer "reservation_time_limit"
    t.float "fine_value", default: 0.0, null: false
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
    t.datetime "modified", precision: nil, default: -> { "now()" }, null: false
    t.integer "modified_by"
  end

  create_table "users_values", primary_key: ["user_id", "key"], force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "key", null: false
    t.string "value", null: false
    t.string "ascii"
  end

  create_table "versions", primary_key: "installed_versions", id: :string, force: :cascade do |t|
  end

  create_table "vocabulary_brief_formats", primary_key: "datafield", id: { type: :string, limit: 3 }, force: :cascade do |t|
    t.text "format", null: false
    t.integer "sort_order"
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
    t.datetime "modified", precision: nil, default: -> { "now()" }, null: false
    t.integer "modified_by"
  end

  create_table "vocabulary_form_datafields", primary_key: "datafield", id: { type: :string, limit: 3 }, force: :cascade do |t|
    t.boolean "collapsed", default: false, null: false
    t.boolean "repeatable", default: false, null: false
    t.string "indicator_1"
    t.string "indicator_2"
    t.string "material_type"
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
    t.datetime "modified", precision: nil, default: -> { "now()" }, null: false
    t.integer "modified_by"
    t.integer "sort_order"
  end

  create_table "vocabulary_form_subfields", primary_key: ["datafield", "subfield"], force: :cascade do |t|
    t.string "datafield", limit: 3, null: false
    t.string "subfield", limit: 1, null: false
    t.boolean "collapsed", default: false, null: false
    t.boolean "repeatable", default: false, null: false
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
    t.datetime "modified", precision: nil, default: -> { "now()" }, null: false
    t.integer "modified_by"
    t.string "autocomplete_type", default: "disabled", null: false
    t.integer "sort_order"
  end

  create_table "vocabulary_idx_autocomplete", id: :serial, force: :cascade do |t|
    t.string "datafield", limit: 3, null: false
    t.string "subfield", limit: 1, null: false
    t.string "word", null: false
    t.string "phrase", null: false
    t.integer "record_id"
    t.index ["datafield", "subfield", "word"], name: "IX_vocabulary_idx_autocomplete_word", opclass: { word: :varchar_pattern_ops }
    t.index ["record_id"], name: "IX_vocabulary_idx_autocomplete_record_id"
  end

  create_table "vocabulary_idx_fields", primary_key: ["record_id", "indexing_group_id", "word", "datafield"], force: :cascade do |t|
    t.integer "record_id", null: false
    t.integer "indexing_group_id", null: false
    t.string "word", null: false
    t.integer "datafield", null: false
    t.index ["word"], name: "IX_vocabulary_idx_fields_word", opclass: :varchar_pattern_ops
  end

  create_table "vocabulary_idx_sort", primary_key: ["record_id", "indexing_group_id"], force: :cascade do |t|
    t.integer "record_id", null: false
    t.integer "indexing_group_id", null: false
    t.string "phrase"
    t.integer "ignore_chars_count"
  end

  create_table "vocabulary_indexing_groups", id: :serial, force: :cascade do |t|
    t.string "translation_key", null: false
    t.text "datafields"
    t.boolean "sortable", default: false, null: false
    t.boolean "default_sort", default: false, null: false
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
    t.datetime "modified", precision: nil, default: -> { "now()" }, null: false
    t.integer "modified_by"
  end

  create_table "vocabulary_records", id: :serial, force: :cascade do |t|
    t.text "iso2709", null: false
    t.string "material", limit: 20
    t.string "database", limit: 10, default: "main", null: false
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
    t.datetime "modified", precision: nil, default: -> { "now()" }, null: false
    t.integer "modified_by"
  end

  create_table "vocabulary_search_results", primary_key: ["search_id", "indexing_group_id", "record_id"], force: :cascade do |t|
    t.integer "search_id", null: false
    t.integer "indexing_group_id", null: false
    t.integer "record_id", null: false
    t.index ["search_id", "record_id"], name: "IX_vocabulary_search_results"
  end

  create_table "vocabulary_searches", id: :serial, force: :cascade do |t|
    t.text "parameters", null: false
    t.datetime "created", precision: nil, default: -> { "now()" }, null: false
    t.integer "created_by"
  end

  create_table "z3950_addresses", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "url", null: false
    t.integer "port", null: false
    t.string "collection", default: "default", null: false
  end

  add_foreign_key "access_control", "access_cards", name: "FK_access_control_access_cards", on_delete: :cascade
  add_foreign_key "access_control", "users", name: "FK_access_control_users", on_delete: :cascade
  add_foreign_key "authorities_form_subfields", "authorities_form_datafields", column: "datafield", primary_key: "datafield", name: "FK_authorities_form_subfields_authorities_form_datafields", on_delete: :cascade
  add_foreign_key "biblio_form_subfields", "biblio_form_datafields", column: "datafield", primary_key: "datafield", name: "FK_biblio_form_subfields_biblio_form_datafields", on_delete: :cascade
  add_foreign_key "biblio_holdings", "biblio_records", column: "record_id", name: "fk_biblio_holdings_biblio_records", on_delete: :cascade
  add_foreign_key "holding_form_subfields", "holding_form_datafields", column: "datafield", primary_key: "datafield", name: "FK_holding_form_subfields_holding_form_datafields", on_delete: :cascade
  add_foreign_key "lending_fines", "lendings", name: "FK_lending_fines_lendings", on_delete: :cascade
  add_foreign_key "lending_fines", "users", name: "FK_lending_fines_users", on_delete: :cascade
  add_foreign_key "lendings", "biblio_holdings", column: "holding_id", name: "fk_lendings_biblio_holdings", on_delete: :cascade
  add_foreign_key "lendings", "lendings", column: "previous_lending_id", name: "fk_lendings_lendings", on_delete: :cascade
  add_foreign_key "lendings", "users", name: "fk_lendings_users", on_delete: :cascade
  add_foreign_key "orders", "quotations", name: "FK_orders_quotations", on_update: :cascade, on_delete: :cascade
  add_foreign_key "permissions", "logins", name: "FK_permissions_logins", on_delete: :cascade
  add_foreign_key "quotations", "suppliers", name: "FK_quotations_suppliers", on_update: :cascade, on_delete: :cascade
  add_foreign_key "request_quotation", "quotations", name: "FK_request_quotation_quotations", on_delete: :cascade
  add_foreign_key "request_quotation", "requests", name: "FK_request_quotation_requests", on_delete: :cascade
  add_foreign_key "reservations", "biblio_records", column: "record_id", name: "fk_reservations_biblio_records", on_delete: :cascade
  add_foreign_key "reservations", "users", name: "fk_lendings_users", on_delete: :cascade
  add_foreign_key "users_values", "users", name: "FK_users_values_users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "users_values", "users_fields", column: "key", primary_key: "key", name: "FK_users_values_users_fields", on_update: :cascade, on_delete: :cascade
  add_foreign_key "vocabulary_form_subfields", "vocabulary_form_datafields", column: "datafield", primary_key: "datafield", name: "FK_vocabulary_form_subfields_vocabulary_form_datafields", on_delete: :cascade
end
