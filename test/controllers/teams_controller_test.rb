require 'test_helper'

class TeamsControllerTest < ActionController::TestCase
  setup do
    @team = teams(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:teams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create team" do
    assert_difference('Team.count') do
      post :create, team: { best_streak: @team.best_streak, blowouts: @team.blowouts, current_streak: @team.current_streak, efficiency: @team.efficiency, highest_score: @team.highest_score, losses: @team.losses, lowest_score: @team.lowest_score, name: @team.name, owners: @team.owners, points_against: @team.points_against, points_for: @team.points_for, post_losses: @team.post_losses, post_wins: @team.post_wins, ties: @team.ties, top_gm: @team.top_gm, wins: @team.wins }
    end

    assert_redirected_to team_path(assigns(:team))
  end

  test "should show team" do
    get :show, id: @team
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @team
    assert_response :success
  end

  test "should update team" do
    patch :update, id: @team, team: { best_streak: @team.best_streak, blowouts: @team.blowouts, current_streak: @team.current_streak, efficiency: @team.efficiency, highest_score: @team.highest_score, losses: @team.losses, lowest_score: @team.lowest_score, name: @team.name, owners: @team.owners, points_against: @team.points_against, points_for: @team.points_for, post_losses: @team.post_losses, post_wins: @team.post_wins, ties: @team.ties, top_gm: @team.top_gm, wins: @team.wins }
    assert_redirected_to team_path(assigns(:team))
  end

  test "should destroy team" do
    assert_difference('Team.count', -1) do
      delete :destroy, id: @team
    end

    assert_redirected_to teams_path
  end
end
