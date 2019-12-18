class StaticPagesController < ApplicationController
    def index
    end

    def create    
        @filmster = Filmster.create(filmster_params)
        if @filmster.valid?
          flash[:success] = "Your filmster has been posted!"
        else
          flash[:alert] = "Woops! Looks like there has been an error!"
        end
        redirect_to root_path
    end

    def update
        @filmster = Filmster.find(params[:id])
        if @filmster.update(filmster_params)
            flash[:success] = "The filmster has been updated!"
            redirect_to root_path
        else
            flash[:alert] = "Woops! Looks like there has been an error!"
            redirect_to edit_filmster_path(params[:id])
        end
    end

    def destroy
        @filmster = Filmster.find(params[:id])
        @filmster.destroy
        flash[:success] = "The filmster was successfully deleted!"
        redirect_to root_path
    end
end
