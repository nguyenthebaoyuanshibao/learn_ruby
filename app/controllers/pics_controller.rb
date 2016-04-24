class PicsController < ApplicationController
    before_action :find_pic, only: [:show, :edit, :update, :destroy, :upvote]
    before_action :authenticate_user!, except: [:index, :show]
    def index  
        @pics =Pic.all
        if params[:search]
          @pics = Pic.search(params[:search]).order("created_at DESC")
        else
          @pics=Pic.all.order("created_at DESC")    
        end
    end
    def show
        @pic_comment = PicComment.new
    end
    
    def new
        @pic= current_user.pics.build
    end  
    def create
        @pic=current_user.pics.build(pic_params)
        if @pic.save
          redirect_to @pic, notice: "Yesss! It was posted!"
        else 
          render 'new'
        end
    end
    def edit
    end
    def update
        if @pic.update(pic_params)
            redirect_to @pic, notice: "Congrats! Pics was updated!"
        else 
            render 'edit'
        end
    end
    def destroy
        @pic.destroy
        redirect_to root_path
    end
    def upvote
      @pic.upvote_by current_user
      redirect_to :back
    end    
    private
      def pic_params
          params.require(:pic).permit(:title, :description, :image)
      end
    def find_pic
        @pic= Pic.find(params[:id])
    end
end
