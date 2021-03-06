class BooksController < ApplicationController
  before_action :load_books, only: :index
  before_action :load_book, only: :show
  before_action :new_book, only: :create

  # def index
  # end
  #
  # def new
  # end
  #
  # def edit
  # end

  def create
    if new_book.save
      redirect_to books_path
    else
      redirect_to new_book_path
    end
  end

  def filter
    render template: 'books/filter', locals: { books: filter_books }
  end

  def show
  end

  # def destroy
  # end

  private

  def filter_params
    permited_params
      .slice(:title, :isbn)
      .merge(category.present? ? { category_id: category.id } : {})
      .reject{ |k, v| v.to_s.empty? }
  end

  def filter_books
    Book.where(filter_params)
  end

  def category
    Category.find_by(name: permited_params[:category_name])
  end

  def load_books
    @books = Book.all
  end

  def load_book
    @book = Book.find(params[:id])
  end

  def new_book
    @book = Book.new(title: params[:title], isbn: params[:isbn], category_name: params[:category_name])
  end

  def permited_params
    params.permit(:title, :isbn, :category_id, :category_name)
  end
end
