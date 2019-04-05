require 'test_helper'

class GroupsControllerTest < ActionDispatch::IntegrationTest
  test "group create" do
    url = "あああ"
    name = "NAME"
    email = "EMAIL"
    password = "PASSWORD"
    password_confirmation = "PASSWORD"

    # post create_group_path, params: {
    #   url: url, name: name, email: email, password: password, password_confirmation: password_confirmation}
    @group = Group.new(
      url: url,
      name: name,
      email: email,
      password: password,
      password_confirmation: password_confirmation)
    p @group
    puts "url: #{@group.url}"
    puts "name: #{@group.name}"
    puts "email: #{@group.email}"
    puts "password: #{@group.password}"
    puts "password_confirmation: #{@group.password_confirmation}"
    puts "password_digest: #{@group.password_digest}"
    puts "valid? #{@group.valid?}"
    puts "error? #{@group.errors.messages}"
    assert @group.save
    # if @group.save
    #   flash[:notice] = "グループ登録が完了しました"
    #   redirect_to(top_group_path(@group.url))
    # else
    #   @url = params[:url]
    #   @name = params[:name]
    #   @email = params[:email]
    #   @password = params[:password]
    #   render("groups/new")
    # end
  end
end
