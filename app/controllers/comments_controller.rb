class CommentsController < ApplicationController
  load_and_authorize_resource
  
  def create
    @comment = current_user.comments.build(params[:comment])
    @round = @comment.round
    
    respond_to do |format|
      if @comment.save
        format.html { redirect_to(@comment.round, :notice => t('controllers.comments.create.success')) }
        format.json  { render :json => @comment, :status => :created }
      else
        format.html { render :template => 'rounds/show' }
        format.json  { render :json => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @round = @comment.round
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @comment.round }
      format.json  { head :ok }
    end
  end
end
