require 'rails_helper'


  RSpec.describe TodosController, type: :controller do
      before do
        @user = User.create!(:email => "1234@1234", :password => "12345678")
        @team = Team.create!(name: "123", user: @user)
        @project = Project.create!(title: "project 1", user: @user, team: @team)
        @todo = Todo.create!(title: "1234", user: @user, project: @project, team: @team)
        sign_in(@user)
      end

      describe "show new edit " do
        it "should go to show page" do
        get :show, :id => @todo.id, :project_id => @project.id, :team_id => @team.id, :user => @user
        expect(response).to render_template(:show)
      end

        it "should go to new page" do
        get :new, :id => @todo.id, :project_id => @project.id, :team_id => @team.id, :user => @user
        expect(response).to render_template(:new)
  end
        it "should go to edit page" do
        get :edit, :id => @todo.id, :project_id => @project.id, :team_id => @team.id, :user => @user
        expect(response).to render_template(:edit)
      end
    end

end
