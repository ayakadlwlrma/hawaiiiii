class Admin::AlohasController < ApplicationController
    before_action :if_not_admin
    before_action :set_aloha, only: [:new, :edit, :create]
    
    def create
        aloha = Aloha.new(aloha_params)
        aloha.user_id = current_user.id

        if aloha.save
          p params[:aloha][:images]
          params[:aloha][:images]&.each do |image|
              p image
              Image.create!(image: image, aloha_id: aloha.id)
          end

          if aloha.category == 'グルメ'
            redirect_url = '/alohas/food'
          elsif aloha.category == 'スポット'
            redirect_url = '/alohas/spot'
          elsif aloha.category =='お土産'
            redirect_url = '/alohas/omiyage'
          else
            redirect_url = '/alohas/leisure'
          end

        else
          redirect_url = '/alohas/new'

        end
 end

 def new
    @aloha = Aloha.new
  end


    

  def show
    @aloha = Aloha.find_by(params[:id])
    @comments = @aloha.comments
    @comment = Comment.new
    @rank = @aloha.comments.average(:star)
  end

  def edit
    @aloha = Aloha.find(params[:id])
  end

  def update
    aloha = Aloha.find(params[:id])
    if aloha.update(aloha_params)
      redirect_to :action => "show", :id => aloha.id
    else
      redirect_to :action => "new"
    end
  end

  def destroy
    aloha = Aloha.find(params[:id])

    if aloha.category == 'グルメ'
      redirect_url = '/alohas/food'
    elsif aloha.category == 'スポット'
      redirect_url = '/alohas/spot'
    elsif aloha.category =='お土産'
      redirect_url = '/alohas/omiyage'
    else
      redirect_url = '/alohas/leisure'
    end
    
    aloha.destroy
    redirect_to redirect_url

end

  def food
    @alohas = Aloha.all
    @ranked_posts = Aloha
    .left_joins(:comments)
    .select("alohas.*, COALESCE(AVG(CAST(comments.star AS DECIMAL)), 0) as average_star")
    .group("alohas.id")
    .where(category: "グルメ")
    .order("average_star DESC")
    .limit(5)
  end

  def spot
    @alohas = Aloha.all
    @ranked_posts = Aloha
    .left_joins(:comments)
    .select("alohas.*, COALESCE(AVG(CAST(comments.star AS DECIMAL)), 0) as average_star")
    .group("alohas.id")
    .where(category: "スポット")
    .order("average_star DESC")
    .limit(5)
  
end

  def leisure
    @alohas = Aloha.all
    @ranked_posts = Aloha
    .left_joins(:comments)
    .select("alohas.*, COALESCE(AVG(CAST(comments.star AS DECIMAL)), 0) as average_star")
    .group("alohas.id")
    .where(category: "レジャー")
    .order("average_star DESC")
    .limit(5)
end

  def omiyage
    @alohas = Aloha.all
    @ranked_posts = Aloha
    .left_joins(:comments)
    .select("alohas.*, COALESCE(AVG(CAST(comments.star AS DECIMAL)), 0) as average_star")
    .group("alohas.id")
    .where(category: "お土産")
    .order("average_star DESC")
    .limit(5)
end
    private
    def if_not_admin
        redirect_to root_path unless current_user.admin?
    end
    def set_aloha
        @aloha = Aloha.new
    end
    def aloha_params
        params.require(:aloha).permit(:name, :time, :category, :about, :price, :link, :parking, :point, :photo, :address, :phonenumber)
    end
end
