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

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :projects
  has_many :teams
  has_many :todos
  has_many :team_relationships
  has_many :participated_teams, :through => :team_relationships, source: :team
  has_many :team_owners
  has_many :owned_teams, :through => :team_owners, source: :team
  has_many :events
  def is_member_of?(team)
    participated_teams.include?(team)
  end

  def is_owner_of?(team)
    owned_teams.include?(team)
  end

  def own!(team)
    owned_teams << team
  end

  def join!(team)
    participated_teams << team
  end

  def quit!(team)
    participated_teams.delete(team)
  end
end
