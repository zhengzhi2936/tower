require "rails_helper"

RSpec.describe TeamsController, :type => :controller do
  before do
    @user = User.create!(:email => "1234@1234", :password => "12345678")
    @team = Team.create!(name: "123", user: @user)
    @project = Project.create!(title: "project 1", user: @user, team: @team)
    @todo = Todo.create!(title: "1234", description: "1324", user: @user, project: @project, team: @team)
    sign_in(@user)
  end
  describe "GET #index show edit" do
    it "responds successfully with an HTTP 200 status code" do
      get :index, :team_id => @team.id, :user => @user
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index, :id => @todo.id, :project_id => @project.id, :team_id => @team.id, :user => @user
      expect(response).to render_template("index")
    end
  end
end 
