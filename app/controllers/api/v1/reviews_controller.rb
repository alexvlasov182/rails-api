class Api::V1::ReviewsController < ApplicationController
  before_action :load_book, only: :index
  before_action :load_review, only: %i[show update destroy]
  before_action :authenticate_with_token!, only: %i[create update destroy]
  def index
    @reviews = @book.reviews
    reviews_serializer = parse_json @reviews
    json_response 'Index reviews successfully', true, { reviews: reviews_serializer }, :ok
  end

  def show
    review_serializer = parse_json @review
    json_response 'Show review successfully', true, { review: review_serializer }, :ok
  end

  def create
    review = Review.new review_params
    review.user_id = current_user.id
    review.book_id = params[:book_id]
    if review.save
      review_serializer = parse_json review
      json_response 'Created review successfully', true, { review: review_serializer }, :ok
    else
      json_response 'Created review fail', false, {}, :unprocessable_entity
    end
  end

  def update
    if correct_user @review.user
      if @review.update review_params
        review_serializer = parse_json @review
        json_response 'Update review successfully', true, { review: review_serializer }, :ok
      else
        json_response 'Update review fail', false, {}, :unprocessable_entity
      end
    else
      json_response 'You dont have permission to do this', false, {}, :unauthorized
    end
  end

  def destroy
    if correct_user @review.user
      if @review.destroy
        json_response 'Deleted review successfully', true, {}, :ok
      else
        json_response 'Deleted review fail', false, {}, :unprocessable_entity
      end
    else
      json_response 'You dont have permission to do this', false, {}, :unauthorized
    end
  end

  private

  def load_book
    @book = Book.find_by id: params[:book_id]
    json_response 'Cannot find a book', false, {}, :not_found unless @book.present?
  end

  def load_review
    @review = Review.find_by id: params[:id]
    json_response 'Cannot find a review', false, {}, :not_found unless @review.present?
  end

  def review_params
    params.require(:review).permit :title, :content_rating, :recommend_rating
  end
end
