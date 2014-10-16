class BlogController < ApplicationController
  def index
    @posts = Blog::Post.all.order("created_at asc")
  end

  def show
  end

  def create
  end
end
