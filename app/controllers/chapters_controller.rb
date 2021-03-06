class ChaptersController < ApplicationController
    # skip_before_action :authorized, only: [:index]
    def index
        @chapters = current_user.notebook.chapters 
        @chapters_with_page_count = []
        @chapters.each do |chapter|
            new_obj = {}
            new_obj[:id] = chapter.id
            new_obj[:title] = chapter.title
            new_obj[:notebook_id] = chapter.notebook_id
            new_obj[:page_count] = chapter.pages.count
            @chapters_with_page_count.push(new_obj)
        end
        render json: @chapters_with_page_count
    end

    def create
        # byebug
        @chapter = Chapter.new(notebook_params)
        @chapter.notebook = current_user.notebook
        @chapter.save
        
        @chapters = current_user.notebook.chapters 
        @chapters_with_page_count = []
        @chapters.each do |chapter|
            new_obj = {}
            new_obj[:id] = chapter.id
            new_obj[:title] = chapter.title
            new_obj[:notebook_id] = chapter.notebook_id
            new_obj[:page_count] = chapter.pages.count
            @chapters_with_page_count.push(new_obj)
        end
        render json: @chapters_with_page_count
    end


    def this_chapter
        # byebug
        chapter = Chapter.all.find(params["id"])
        if chapter.pages.length == 0
            render json: {error: "No pages yet"}
        else
            render json: chapter.pages
        end
    end


    private

    def notebook_params
        params.require(:chapter).permit(:title)
    end

end
