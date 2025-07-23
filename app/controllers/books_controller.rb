# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    @books = Book.all
    @book_infos = @books.to_h do |book|
      [ book.isbn, BookInfoFetcher.fetch(book.isbn) ]
    end
  end

  def show
    @book = Book.find_by(isbn: params[:id])
    @reviews = Review.where(isbn: @book&.isbn)
    @book_info = BookInfoFetcher.fetch(@book.isbn)
  end
end
