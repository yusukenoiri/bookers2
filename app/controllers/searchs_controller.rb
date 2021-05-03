class SearchsController < ApplicationController
    def search
        @range = params[:range]
        search = params[:search]
        @word = params[:word]
        # byebug

        if @range == '1'
          # @user = User.search(params[:search],params[:word])
           @user = User.search(search,@word)
        else
           @book = Book.search(search,@word)
        end
    end
end
