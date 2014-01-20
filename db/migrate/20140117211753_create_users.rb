class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :image_url
      t.string :facebook_id, :default => 0
      t.string :linkedin_id, :default => 0
      t.string :meetup_id, :default => 0
      t.string :facebook_access_token
      t.string :meetup_access_token
      t.string :linkedin_access_token
      t.datetime :facebook_expires_at

      t.timestamps
    end
  end
end