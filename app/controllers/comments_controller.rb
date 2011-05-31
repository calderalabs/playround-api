class CommentsController < ApplicationController
  load_and_authorize_resource
  
  def create
    @comment = current_user.comments.build(params[:comment])
    @round = @comment.round
    
    respond_to do |format|
      if @comment.save
        format.html { redirect_to(@comment.round, :notice => 'Comment was successfully added.') }
        format.xml  { render :xml => @comment, :status => :created, :location => @round }
      else
        format.html { render :template => 'rounds/show' }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @round = @comment.round
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @comment.round }
      format.xml  { head :ok }
    end
  end
end
