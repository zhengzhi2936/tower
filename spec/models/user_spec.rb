# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role                   :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'rails_helper'

  RSpec.describe Team, type: :model do
    before do
      @user = User.create!(:email => "123456@123456", :password => "123456")
      @team = Team.new(:name => "1", :user_id => "1")
    end
    it "should be a member of group" do
      # t = Team.new(:name => "1", :user => )
      # u = User.create!(:email => "123456@123456", :password => "123456")
      @user.join!(@team)
      expect(@user.is_member_of?(@team)).to eq(true)
    end

    it "should quit group" do
      # t = Team.new(:name => "1", :user_id => 1)
      # u = User.create!(:email => "123456@123456", :password => "123456")
      @user.participated_teams << @team
      @user.quit!(@team)
      expect(@user.is_member_of?(@team)).to eq(false)
    end

    it "should be admin" do
      # t = Team.new(:name => "1", :user_id => 1)
      # u = User.create!(:email => "123456@123456", :password => "123456")
      @user.role = "admin"
      @user.save!
      expect(@user.admin?).to eq(true)
    end

    it "should be member" do
      # t = Team.new(:name => "1", :user_id => 1)
      # u = User.create!(:email => "123456@123456", :password => "123456")
      @user.role = "member"
      @user.save!
      expect(@user.member?).to eq(true)
    end
  end
