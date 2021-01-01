class SubforumsController < ApplicationController
  before_action :set_forum, only: %i[create]
  before_action :set_subforum, only: %i[update destroy]

  def create
    @forum.subforums.create!(subforum_params)
    json_response(forums: Forum.all)
  end

  def update
    if @subforum.update(subforum_params)
      json_response(forums: Forum.all)
    else
      json_response(errors: @forum.errors.full_messages)
    end
  end

  def destroy
    @subforum.destroy
    json_response(forums: Forum.all)
  end

  private

  def set_forum
    @forum = Forum.find(params[:subforum][:forum_id])
  end

  def set_subforum
    @subforum = Subforum.find(params[:id])
  end

  def subforum_params
    params.require(:subforum).permit(:name)
  end
end