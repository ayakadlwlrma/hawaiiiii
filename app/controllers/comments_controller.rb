class CommentsController < ApplicationController
    before_action :authenticate_user!

    def create
      aloha = Aloha.find(params[:aloha_id])
      comment = aloha.comments.build(comment_params)
      if comment.save
        flash[:success] = "コメントしました"
        redirect_back(fallback_location: root_path) 
      else
        flash[:success] = "コメントできませんでした"
        redirect_back(fallback_location: root_path) 
      end
    end
  
    private
  
      def comment_params
        params.require(:comment).permit(:content, :star)
      end
end
