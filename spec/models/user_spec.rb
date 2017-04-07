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
