class TripsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)

    if @trip.save
      render json: @trip, status: :created
    else
      render json: @trip.errors, status: :unprocessable_entity
    end
  end

  def weekly
    render json: TripStats.weekly_stats.to_json
  end

  def monthly
    if order_param_correct? && order_type_correct?
      orderParam = sort_params[:orderParam]
      orderType = sort_params[:orderType]
      render json: TripPresenter.monthly_stats_serialized(orderParam, orderType).to_json
    else
      render json: 'Invalid params', status: :unprocessable_entity
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:start_address, :destination_address, :price)
  end

  def sort_params
    params.permit(:orderParam, :orderType)
  end

  def order_param_correct?
    correct_values = %w[day total_distance avg_ride avg_price]
    correct_values.include?(sort_params[:orderParam]) || !sort_params[:orderParam]
  end

  def order_type_correct?
    correct_values = %w[asc desc]
    correct_values.include?(sort_params[:orderType]) || !sort_params[:orderType]
  end
end
