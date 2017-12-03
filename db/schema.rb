# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 0) do
  create_table 'users', force: true do |t|
    t.string 'username', null: false
    t.string 'password', null: false
    t.string 'email'
    t.integer 'age'
  end

  add_index :users, :username, unique: true

  create_table 'courts', force: true do |t|
    t.belongs_to :users
    t.float 'longitude', null: false
    t.float 'latidute', null: false
  end

  create_table 'teams', force: true do |t|
    t.belongs_to :users
    t.string 'name', null: false
    t.integer 'size', null: false
  end

  create_table 'reservations', force: true do |t|
    t.integer 'court_id', null: false
    t.string 'start_time', null: false
    t.string 'end_time', null: false
  end

  create_table 'teams_users' do |t|
    t.integer :user_id
    t.integer :team_id
  end

  create_table 'messages', force: true do |t|
    t.string 'text', null: false
    t.string 'date', null: false
    t.integer :user_id
  end
end
