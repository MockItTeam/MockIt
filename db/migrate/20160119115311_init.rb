class Init < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :username
      t.string :pin
      t.integer :status, default: 0, index: true
      t.timestamps null: false
    end
    add_index(:users, :username, unique: true)

    create_table :projects do |t|
      t.string :name
      t.references :user
      t.integer :status, default: 0, index: true
      t.timestamps null: false
    end

    create_table :projects_users, id: false do |t|
      t.belongs_to :project, index: true
      t.belongs_to :user, index: true
    end

    create_table :invitations do |t|
      t.integer :from_user_id, index: true
      t.integer :to_user_id, index: true
      t.references :project
      t.integer :status, default: 0, index: true
      t.timestamps null: false
    end

    create_table :raw_images do |t|
      t.references :user
      t.integer :status, default: 0, index: true
      t.timestamps null: false
    end

    create_table :mockups do |t|
      t.string :description
      t.references :raw_image
      t.references :user
      t.references :project
      t.integer :status, default: 0, index: true
      t.timestamps null: false
    end
  end

  def down
    drop_table :mockups
    drop_table :raw_images
    drop_table :invitations
    drop_table :projects_users
    drop_table :projects
    drop_table :users
  end
end

# rake db:migrate VERSION=0

=begin
  rails g model User --migration=false
  rails g model Project --migration=false
  rails g model Invitation --migration=false
  rails g model RawImage --migration=false
  rails g model Mockup --migration=false
=end

