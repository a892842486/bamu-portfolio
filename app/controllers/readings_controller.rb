class ReadingsController < ApplicationController
  # 之後選定精選文章時，填入對應的 Reading ID
  FEATURED_READING_IDS = [ 16, 45, 70, 52, 21 ].freeze

  def index
    @search_query = params[:q].to_s.strip

    @readings = Reading.ordered
    @readings = @readings.where("title LIKE ?", "%#{@search_query}%") if @search_query.present?

    @readings_by_year = @readings.to_a.group_by do |reading|
      (reading.read_at || reading.created_at.to_date).year
    end

    @featured_readings = Reading.where(id: FEATURED_READING_IDS).ordered
  end

  def show
    @reading = Reading.find(params[:id])
  end
end
