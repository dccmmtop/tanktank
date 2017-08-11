module Wechat
  class CommentsController < Wechat::BaseController
    
    def create
      @passage = Passage.find(params[:passage_id])
      @comment = @passage.comments.new(params[:comment].permit!)
      @comment.user_id = current_user.id
      @comment.save
    end
    
  end
end