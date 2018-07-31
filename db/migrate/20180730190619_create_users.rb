class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, null: false, index: true, unique: true
      t.string :password_digest
      t.string :role, null: false, default: 'user'
      t.datetime :last_login
      
      t.timestamps
    end
  	execute "SELECT setval('users_id_seq', 1000)"
  end

end
