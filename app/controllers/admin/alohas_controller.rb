class Admin::AlohasController < ApplicationController
    before_action :if_not_admin
    before_action :set_aloha, only: [:new, :edit, :create]
    
    
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
