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

ActiveRecord::Schema.define(version: 2018_07_30_190619) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_profile", id: :serial, force: :cascade do |t|
    t.string "picture", limit: 100, null: false
    t.string "signature", limit: 100, null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "account_profile_user_id_key", unique: true
  end

  create_table "account_userrelation", id: :serial, force: :cascade do |t|
    t.integer "object_id", null: false
    t.integer "content_type_id", null: false
    t.integer "user_id", null: false
    t.index ["content_type_id"], name: "account_userrelation_417f1b1c"
    t.index ["user_id"], name: "account_userrelation_e8701ad4"
  end

  create_table "auth_group", id: :serial, force: :cascade do |t|
    t.string "name", limit: 80, null: false
    t.index ["name"], name: "auth_group_name_a6ea08ec_like", opclass: :varchar_pattern_ops
    t.index ["name"], name: "auth_group_name_key", unique: true
  end

  create_table "auth_group_permissions", id: :serial, force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "permission_id", null: false
    t.index ["group_id", "permission_id"], name: "auth_group_permissions_group_id_0cd325b0_uniq", unique: true
    t.index ["group_id"], name: "auth_group_permissions_0e939a4f"
    t.index ["permission_id"], name: "auth_group_permissions_8373b171"
  end

  create_table "auth_permission", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.integer "content_type_id", null: false
    t.string "codename", limit: 100, null: false
    t.index ["content_type_id", "codename"], name: "auth_permission_content_type_id_01ab375a_uniq", unique: true
    t.index ["content_type_id"], name: "auth_permission_417f1b1c"
  end

  create_table "auth_user", id: :serial, force: :cascade do |t|
    t.string "password", limit: 128, null: false
    t.datetime "last_login"
    t.boolean "is_superuser", null: false
    t.string "username", limit: 150, null: false
    t.string "first_name", limit: 30, null: false
    t.string "last_name", limit: 30, null: false
    t.string "email", limit: 254, null: false
    t.boolean "is_staff", null: false
    t.boolean "is_active", null: false
    t.datetime "date_joined", null: false
    t.index ["username"], name: "auth_user_username_6821ab7c_like", opclass: :varchar_pattern_ops
    t.index ["username"], name: "auth_user_username_key", unique: true
  end

  create_table "auth_user_groups", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "group_id", null: false
    t.index ["group_id"], name: "auth_user_groups_0e939a4f"
    t.index ["user_id", "group_id"], name: "auth_user_groups_user_id_94350c0c_uniq", unique: true
    t.index ["user_id"], name: "auth_user_groups_e8701ad4"
  end

  create_table "auth_user_user_permissions", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "permission_id", null: false
    t.index ["permission_id"], name: "auth_user_user_permissions_8373b171"
    t.index ["user_id", "permission_id"], name: "auth_user_user_permissions_user_id_14a6b632_uniq", unique: true
    t.index ["user_id"], name: "auth_user_user_permissions_e8701ad4"
  end

  create_table "customer_call", id: :serial, force: :cascade do |t|
    t.integer "object_id", null: false
    t.string "phone", limit: 15, null: false
    t.boolean "resolved", null: false
    t.integer "content_type_id", null: false
    t.string "name", limit: 100, null: false
    t.index ["content_type_id"], name: "customer_call_417f1b1c"
  end

  create_table "customer_customer", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "email", limit: 50
    t.string "phone", limit: 15, null: false
    t.string "address_name", limit: 255, null: false
    t.string "address_number", limit: 10, null: false
    t.string "address_neighborhood", limit: 255, null: false
    t.string "address_city", limit: 255, null: false
    t.string "address_state", limit: 2, null: false
    t.string "address_zipcode", limit: 10, null: false
    t.string "national_registration_code", limit: 18, null: false
    t.boolean "notify_exam_created", null: false
    t.boolean "notify_report_finished", null: false
    t.string "cpf", limit: 11
    t.index ["cpf"], name: "customer_customer_cpf_e6545718_like", opclass: :varchar_pattern_ops
    t.index ["cpf"], name: "customer_customer_cpf_e6545718_uniq", unique: true
    t.index ["email"], name: "customer_customer_email_3a520497_like", opclass: :varchar_pattern_ops
    t.index ["email"], name: "customer_customer_email_3a520497_uniq", unique: true
  end

  create_table "django_admin_log", id: :serial, force: :cascade do |t|
    t.datetime "action_time", null: false
    t.text "object_id"
    t.string "object_repr", limit: 200, null: false
    t.integer "action_flag", limit: 2, null: false
    t.text "change_message", null: false
    t.integer "content_type_id"
    t.integer "user_id", null: false
    t.index ["content_type_id"], name: "django_admin_log_417f1b1c"
    t.index ["user_id"], name: "django_admin_log_e8701ad4"
  end

  create_table "django_content_type", id: :serial, force: :cascade do |t|
    t.string "app_label", limit: 100, null: false
    t.string "model", limit: 100, null: false
    t.index ["app_label", "model"], name: "django_content_type_app_label_76bd3d3b_uniq", unique: true
  end

  create_table "django_migrations", id: :serial, force: :cascade do |t|
    t.string "app", limit: 255, null: false
    t.string "name", limit: 255, null: false
    t.datetime "applied", null: false
  end

  create_table "django_session", primary_key: "session_key", id: :string, limit: 40, force: :cascade do |t|
    t.text "session_data", null: false
    t.datetime "expire_date", null: false
    t.index ["expire_date"], name: "django_session_de54fa62"
    t.index ["session_key"], name: "django_session_session_key_c0390e0f_like", opclass: :varchar_pattern_ops
  end

  create_table "exam_attachmentfile", id: :serial, force: :cascade do |t|
    t.string "file", limit: 100, null: false
    t.string "comment", limit: 250, null: false
    t.integer "exam_id", null: false
    t.index ["exam_id"], name: "exam_attachmentfile_09631ec7"
  end

  create_table "exam_breed", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.integer "specie_id", null: false
    t.index ["specie_id"], name: "exam_breed_79efab21"
  end

  create_table "exam_exam", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.integer "age", null: false
    t.string "age_type", limit: 1, null: false
    t.string "gender", limit: 1, null: false
    t.text "historic", null: false
    t.text "suspicion", null: false
    t.string "price", limit: 9, null: false
    t.string "state", limit: 1, null: false
    t.integer "breed_id", null: false
    t.integer "requester_id"
    t.integer "specie_id", null: false
    t.integer "submitter_id", null: false
    t.datetime "state_update", null: false
    t.boolean "sedated", null: false
    t.string "discount", limit: 9, null: false
    t.string "discount_reason", limit: 100, null: false
    t.integer "old_clinic_id"
    t.boolean "require_report", null: false
    t.integer "age_month", null: false
    t.integer "customer_id"
    t.integer "veterinary_id"
    t.integer "clinic_id"
    t.index ["breed_id"], name: "exam_exam_f9ab8427"
    t.index ["clinic_id"], name: "exam_exam_af351217"
    t.index ["customer_id"], name: "exam_exam_26a50868"
    t.index ["old_clinic_id"], name: "exam_exam_d06b3462"
    t.index ["requester_id"], name: "exam_exam_573f8683"
    t.index ["specie_id"], name: "exam_exam_79efab21"
    t.index ["submitter_id"], name: "exam_exam_a8919bbb"
    t.index ["veterinary_id"], name: "exam_exam_09a174ac"
  end

  create_table "exam_exam_notifiers", id: :serial, force: :cascade do |t|
    t.integer "exam_id", null: false
    t.integer "requester_id", null: false
    t.index ["exam_id", "requester_id"], name: "exam_exam_notifiers_exam_id_c30ffdcc_uniq", unique: true
    t.index ["exam_id"], name: "exam_exam_notifiers_09631ec7"
    t.index ["requester_id"], name: "exam_exam_notifiers_573f8683"
  end

  create_table "exam_examstatechanges", id: :serial, force: :cascade do |t|
    t.string "state", limit: 1, null: false
    t.datetime "time", null: false
    t.integer "exam_id", null: false
    t.index ["exam_id"], name: "exam_examstatechanges_09631ec7"
  end

  create_table "exam_notification", id: :serial, force: :cascade do |t|
    t.datetime "time", null: false
    t.string "description", limit: 144, null: false
    t.integer "exam_id", null: false
    t.index ["exam_id"], name: "exam_notification_09631ec7"
  end

  create_table "exam_specie", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "icon", limit: 200
  end

  create_table "mailing_message", id: :serial, force: :cascade do |t|
    t.integer "object_id", null: false
    t.datetime "time", null: false
    t.text "request_data", null: false
    t.integer "response_status_code", limit: 2, null: false
    t.text "response_data", null: false
    t.text "error_message", null: false
    t.integer "content_type_id", null: false
    t.string "type_id", limit: 256, null: false
    t.index ["content_type_id"], name: "mailing_message_417f1b1c"
    t.index ["type_id"], name: "mailing_message_94757cae"
  end

  create_table "mailing_messagetype", id: :string, limit: 256, force: :cascade do |t|
    t.string "description", limit: 256, null: false
    t.boolean "enabled", null: false
    t.index ["id"], name: "mailing_messagetype_id_4bf3a8a8_like", opclass: :varchar_pattern_ops
  end

  create_table "news_post", id: :serial, force: :cascade do |t|
    t.string "title", limit: 400, null: false
    t.text "text", null: false
    t.string "picture", limit: 100, null: false
    t.datetime "published", null: false
    t.string "link", limit: 200, null: false
  end

  create_table "oauth2_provider_accesstoken", force: :cascade do |t|
    t.string "token", limit: 255, null: false
    t.datetime "expires", null: false
    t.text "scope", null: false
    t.bigint "application_id"
    t.integer "user_id"
    t.datetime "created", null: false
    t.datetime "updated", null: false
    t.index ["application_id"], name: "oauth2_provider_accesstoken_application_id_b22886e1"
    t.index ["token"], name: "oauth2_provider_accesstoken_token_8af090f8_like", opclass: :varchar_pattern_ops
    t.index ["token"], name: "oauth2_provider_accesstoken_token_8af090f8_uniq", unique: true
    t.index ["user_id"], name: "oauth2_provider_accesstoken_user_id_6e4c9a65"
  end

  create_table "oauth2_provider_application", force: :cascade do |t|
    t.string "client_id", limit: 100, null: false
    t.text "redirect_uris", null: false
    t.string "client_type", limit: 32, null: false
    t.string "authorization_grant_type", limit: 32, null: false
    t.string "client_secret", limit: 255, null: false
    t.string "name", limit: 255, null: false
    t.integer "user_id"
    t.boolean "skip_authorization", null: false
    t.datetime "created", null: false
    t.datetime "updated", null: false
    t.index ["client_id"], name: "oauth2_provider_application_client_id_03f0cc84_like", opclass: :varchar_pattern_ops
    t.index ["client_id"], name: "oauth2_provider_application_client_id_key", unique: true
    t.index ["client_secret"], name: "oauth2_provider_application_client_secret_53133678"
    t.index ["client_secret"], name: "oauth2_provider_application_client_secret_53133678_like", opclass: :varchar_pattern_ops
    t.index ["user_id"], name: "oauth2_provider_application_user_id_79829054"
  end

  create_table "oauth2_provider_grant", force: :cascade do |t|
    t.string "code", limit: 255, null: false
    t.datetime "expires", null: false
    t.string "redirect_uri", limit: 255, null: false
    t.text "scope", null: false
    t.bigint "application_id", null: false
    t.integer "user_id", null: false
    t.datetime "created", null: false
    t.datetime "updated", null: false
    t.index ["application_id"], name: "oauth2_provider_grant_application_id_81923564"
    t.index ["code"], name: "oauth2_provider_grant_code_49ab4ddf_like", opclass: :varchar_pattern_ops
    t.index ["code"], name: "oauth2_provider_grant_code_49ab4ddf_uniq", unique: true
    t.index ["user_id"], name: "oauth2_provider_grant_user_id_e8f62af8"
  end

  create_table "oauth2_provider_refreshtoken", force: :cascade do |t|
    t.string "token", limit: 255, null: false
    t.bigint "access_token_id", null: false
    t.bigint "application_id", null: false
    t.integer "user_id", null: false
    t.datetime "created", null: false
    t.datetime "updated", null: false
    t.index ["access_token_id"], name: "oauth2_provider_refreshtoken_access_token_id_key", unique: true
    t.index ["application_id"], name: "oauth2_provider_refreshtoken_application_id_2d1c311b"
    t.index ["token"], name: "oauth2_provider_refreshtoken_token_d090daa4_like", opclass: :varchar_pattern_ops
    t.index ["token"], name: "oauth2_provider_refreshtoken_token_d090daa4_uniq", unique: true
    t.index ["user_id"], name: "oauth2_provider_refreshtoken_user_id_da837fce"
  end

  create_table "professional_profile", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "phone", limit: 15, null: false
    t.string "emergency_phone", limit: 15, null: false
    t.string "registration_region", limit: 2, null: false
    t.string "registration_number", limit: 12, null: false
    t.string "address_name", limit: 255, null: false
    t.string "address_number", limit: 10, null: false
    t.string "address_neighborhood", limit: 255, null: false
    t.string "address_city", limit: 255, null: false
    t.string "address_state", limit: 2, null: false
    t.string "address_zipcode", limit: 10, null: false
    t.boolean "notify_exam_created", null: false
    t.boolean "notify_report_finished", null: false
    t.boolean "notify_clinic_updated", null: false
    t.string "professional_type", limit: 1, null: false
    t.integer "user_id"
    t.string "email", limit: 100
    t.boolean "is_independent", null: false
    t.index ["user_id"], name: "professional_profile_e8701ad4"
  end

  create_table "professional_relationship", id: :serial, force: :cascade do |t|
    t.datetime "association_date", null: false
    t.integer "clinic_id", null: false
    t.integer "veterinary_id", null: false
    t.index ["clinic_id"], name: "professional_relationship_d06b3462"
    t.index ["veterinary_id"], name: "professional_relationship_09a174ac"
  end

  create_table "report_report", id: :serial, force: :cascade do |t|
    t.string "region", limit: 100, null: false
    t.string "transcript", limit: 100, null: false
    t.text "findings", null: false
    t.string "state", limit: 1, null: false
    t.datetime "started", null: false
    t.datetime "finished"
    t.boolean "read", null: false
    t.integer "consultant_id", null: false
    t.integer "exam_id", null: false
    t.text "image_comment"
    t.integer "image_rating", null: false
    t.index ["consultant_id"], name: "report_report_ca2bd156"
    t.index ["exam_id"], name: "report_report_09631ec7"
  end

  create_table "report_reportstatechanges", id: :serial, force: :cascade do |t|
    t.string "state", limit: 1, null: false
    t.datetime "time", null: false
    t.string "bg_reason", limit: 255, null: false
    t.string "bg_work_remaining", limit: 2, null: false
    t.integer "report_id", null: false
    t.index ["report_id"], name: "report_reportstatechanges_6f78b20c"
  end

  create_table "requester_clinic", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "email", limit: 254, null: false
    t.string "phone", limit: 15, null: false
    t.string "emergency_phone", limit: 15, null: false
    t.string "registration_region", limit: 2
    t.string "registration_number", limit: 12
    t.string "address_name", limit: 255, null: false
    t.string "address_number", limit: 10, null: false
    t.string "address_neighborhood", limit: 255, null: false
    t.string "address_city", limit: 255, null: false
    t.string "address_state", limit: 2, null: false
    t.string "address_zipcode", limit: 10, null: false
    t.string "national_registration_code", limit: 18, null: false
    t.boolean "notify_exam_created", null: false
    t.boolean "notify_report_finished", null: false
    t.boolean "notify_clinic_updated", null: false
    t.boolean "notify_veterinarian_related", null: false
    t.index ["email"], name: "requester_clinic_email_080982f2_like", opclass: :varchar_pattern_ops
    t.index ["email"], name: "requester_clinic_email_080982f2_uniq", unique: true
  end

  create_table "requester_membership", id: :serial, force: :cascade do |t|
    t.boolean "technical_lead", null: false
    t.integer "clinic_id", null: false
    t.integer "vet_id", null: false
    t.datetime "association_date", null: false
    t.index ["clinic_id"], name: "requester_membership_d06b3462"
    t.index ["vet_id"], name: "requester_membership_e6f1dad2"
  end

  create_table "requester_requester", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "email", limit: 254, null: false
    t.string "phone", limit: 15, null: false
    t.string "emergency_phone", limit: 15, null: false
    t.string "registration_region", limit: 2, null: false
    t.string "registration_number", limit: 12, null: false
    t.string "address_name", limit: 255, null: false
    t.string "address_number", limit: 10, null: false
    t.string "address_neighborhood", limit: 255, null: false
    t.string "address_city", limit: 255, null: false
    t.string "address_state", limit: 2, null: false
    t.string "address_zipcode", limit: 10, null: false
    t.boolean "notify_clinic_updated", null: false
    t.boolean "notify_exam_created", null: false
    t.boolean "notify_report_finished", null: false
    t.index ["email"], name: "requester_requester_email_96d132fe_like", opclass: :varchar_pattern_ops
    t.index ["email"], name: "requester_requester_email_96d132fe_uniq", unique: true
  end

  create_table "training_video", id: :serial, force: :cascade do |t|
    t.string "title", limit: 100, null: false
    t.text "embedded_code", null: false
    t.integer "order", limit: 2, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest"
    t.string "role", default: "user", null: false
    t.datetime "last_login"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
  end

  add_foreign_key "account_profile", "auth_user", column: "user_id", name: "account_profile_user_id_bdd52018_fk_auth_user_id"
  add_foreign_key "account_userrelation", "auth_user", column: "user_id", name: "account_userrelation_user_id_56d9fccd_fk_auth_user_id"
  add_foreign_key "account_userrelation", "django_content_type", column: "content_type_id", name: "account_user_content_type_id_a7fa3178_fk_django_content_type_id"
  add_foreign_key "auth_group_permissions", "auth_group", column: "group_id", name: "auth_group_permissions_group_id_b120cbf9_fk_auth_group_id"
  add_foreign_key "auth_group_permissions", "auth_permission", column: "permission_id", name: "auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id"
  add_foreign_key "auth_permission", "django_content_type", column: "content_type_id", name: "auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id"
  add_foreign_key "auth_user_groups", "auth_group", column: "group_id", name: "auth_user_groups_group_id_97559544_fk_auth_group_id"
  add_foreign_key "auth_user_groups", "auth_user", column: "user_id", name: "auth_user_groups_user_id_6a12ed8b_fk_auth_user_id"
  add_foreign_key "auth_user_user_permissions", "auth_permission", column: "permission_id", name: "auth_user_user_per_permission_id_1fbb5f2c_fk_auth_permission_id"
  add_foreign_key "auth_user_user_permissions", "auth_user", column: "user_id", name: "auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id"
  add_foreign_key "customer_call", "django_content_type", column: "content_type_id", name: "customer_cal_content_type_id_d4335aa6_fk_django_content_type_id"
  add_foreign_key "django_admin_log", "auth_user", column: "user_id", name: "django_admin_log_user_id_c564eba6_fk_auth_user_id"
  add_foreign_key "django_admin_log", "django_content_type", column: "content_type_id", name: "django_admin_content_type_id_c4bce8eb_fk_django_content_type_id"
  add_foreign_key "exam_attachmentfile", "exam_exam", column: "exam_id", name: "exam_attachmentfile_exam_id_a3bd16ab_fk_exam_exam_id"
  add_foreign_key "exam_breed", "exam_specie", column: "specie_id", name: "exam_breed_specie_id_ae7d5e8c_fk_exam_specie_id"
  add_foreign_key "exam_exam", "auth_user", column: "submitter_id", name: "exam_exam_submitter_id_c17ad1dc_fk_auth_user_id"
  add_foreign_key "exam_exam", "customer_customer", column: "customer_id", name: "exam_exam_customer_id_0ad81d75_fk_customer_customer_id"
  add_foreign_key "exam_exam", "exam_breed", column: "breed_id", name: "exam_exam_breed_id_3565d873_fk_exam_breed_id"
  add_foreign_key "exam_exam", "exam_specie", column: "specie_id", name: "exam_exam_specie_id_31c8db54_fk_exam_specie_id"
  add_foreign_key "exam_exam", "professional_profile", column: "clinic_id", name: "exam_exam_clinic_id_c11bc148_fk_professional_profile_id"
  add_foreign_key "exam_exam", "professional_profile", column: "veterinary_id", name: "exam_exam_veterinary_id_7186da1f_fk_professional_profile_id"
  add_foreign_key "exam_exam", "requester_clinic", column: "old_clinic_id", name: "exam_exam_old_clinic_id_a1be23d2_fk_requester_clinic_id"
  add_foreign_key "exam_exam", "requester_requester", column: "requester_id", name: "exam_exam_requester_id_d2c3565a_fk_requester_requester_id"
  add_foreign_key "exam_exam_notifiers", "exam_exam", column: "exam_id", name: "exam_exam_notifiers_exam_id_222c2a12_fk_exam_exam_id"
  add_foreign_key "exam_exam_notifiers", "requester_requester", column: "requester_id", name: "exam_exam_notif_requester_id_7160e59d_fk_requester_requester_id"
  add_foreign_key "exam_examstatechanges", "exam_exam", column: "exam_id", name: "exam_examstatechanges_exam_id_d48790a4_fk_exam_exam_id"
  add_foreign_key "exam_notification", "exam_exam", column: "exam_id", name: "exam_notification_exam_id_eb36aaa4_fk_exam_exam_id"
  add_foreign_key "mailing_message", "django_content_type", column: "content_type_id", name: "mailing_mess_content_type_id_446a3e74_fk_django_content_type_id"
  add_foreign_key "mailing_message", "mailing_messagetype", column: "type_id", name: "mailing_message_type_id_272ee5fa_fk_mailing_messagetype_id"
  add_foreign_key "oauth2_provider_accesstoken", "auth_user", column: "user_id", name: "oauth2_provider_accesstoken_user_id_6e4c9a65_fk_auth_user_id"
  add_foreign_key "oauth2_provider_accesstoken", "oauth2_provider_application", column: "application_id", name: "oauth2_provider_accesstoken_application_id_b22886e1_fk"
  add_foreign_key "oauth2_provider_application", "auth_user", column: "user_id", name: "oauth2_provider_application_user_id_79829054_fk_auth_user_id"
  add_foreign_key "oauth2_provider_grant", "auth_user", column: "user_id", name: "oauth2_provider_grant_user_id_e8f62af8_fk_auth_user_id"
  add_foreign_key "oauth2_provider_grant", "oauth2_provider_application", column: "application_id", name: "oauth2_provider_grant_application_id_81923564_fk"
  add_foreign_key "oauth2_provider_refreshtoken", "auth_user", column: "user_id", name: "oauth2_provider_refreshtoken_user_id_da837fce_fk_auth_user_id"
  add_foreign_key "oauth2_provider_refreshtoken", "oauth2_provider_accesstoken", column: "access_token_id", name: "oauth2_provider_refreshtoken_access_token_id_775e84e8_fk"
  add_foreign_key "oauth2_provider_refreshtoken", "oauth2_provider_application", column: "application_id", name: "oauth2_provider_refreshtoken_application_id_2d1c311b_fk"
  add_foreign_key "professional_profile", "auth_user", column: "user_id", name: "professional_profile_user_id_cbdc1039_fk_auth_user_id"
  add_foreign_key "professional_relationship", "professional_profile", column: "clinic_id", name: "professional_rela_clinic_id_b8168dc5_fk_professional_profile_id"
  add_foreign_key "professional_relationship", "professional_profile", column: "veterinary_id", name: "professional__veterinary_id_09d1bbd7_fk_professional_profile_id"
  add_foreign_key "report_report", "auth_user", column: "consultant_id", name: "report_report_consultant_id_b3491be6_fk_auth_user_id"
  add_foreign_key "report_report", "exam_exam", column: "exam_id", name: "report_report_exam_id_13223e36_fk_exam_exam_id"
  add_foreign_key "report_reportstatechanges", "report_report", column: "report_id", name: "report_reportstatechange_report_id_3e7d0e51_fk_report_report_id"
  add_foreign_key "requester_membership", "requester_clinic", column: "clinic_id", name: "requester_membership_clinic_id_8754a561_fk_requester_clinic_id"
  add_foreign_key "requester_membership", "requester_requester", column: "vet_id", name: "requester_membership_vet_id_cc218052_fk_requester_requester_id"
end
