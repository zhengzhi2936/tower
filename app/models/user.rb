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
  has_many :events
  has_many :project_permissions
  has_many :team_permissions

  def is_project_owner?(project_id)
    permission = self.project_permissions.find_by_project_id(project_id)
    if permission.present? && permission.level == "owner"
      true
    else
      false
    end
  end

  def is_project_member?(project_id)
    permission = self.project_permissions.find_by_project_id(project_id)
    if permission.present? && permission.level == "member"
      true
    else
      false
    end
  end

  def is_team_owner?(team_id)
    permission = self.team_permissions.find_by_team_id(team_id)
    if permission.present? && permission.level == "owner"
      true
    else
      false
    end
  end

  def is_team_member?(team_id)
    permission = self.team_permissions.find_by_team_id(team_id)
    if permission.present? && permission.level == "member"
      true
    else
      false
    end
  end

  def has_permission_to_access_to_team?(team_id)
    team_permissions = self.team_permissions.find_by_team_id(team_id)
    if team_permissions.present? and (team_permissions.level == "owner" or team_permissions.level == "member")
      true
    else
      false
    end
  end

  def has_permission_to_operate_todo?(project_id)
    permission = self.project_permissions.find_by_project_id(project_id)
    if permission.present? && (permission.level == "owner" or permission.level == "member")
      true
    else
      false
    end
  end
end
