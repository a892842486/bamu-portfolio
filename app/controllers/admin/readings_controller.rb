class Admin::ReadingsController < ApplicationController
  # 在此沿用專案現有的 Admin 登入驗證機制
  # 例如：before_action :authenticate_admin!

  before_action :set_reading, only: [ :edit, :update, :destroy ]

  def index
    @readings = Reading.order(created_at: :desc)
  end

  def new
    @reading = Reading.new
  end

  def create
    @reading = Reading.new(reading_params)

    if @reading.save
      redirect_to admin_readings_path, notice: "文章新增成功。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @reading.update(reading_params)
      redirect_to admin_readings_path, notice: "文章更新成功。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @reading.destroy
    redirect_to admin_readings_path, notice: "文章刪除成功。"
  end

  private

  def set_reading
    @reading = Reading.find(params[:id])
  end

  def reading_params
    params.require(:reading).permit(
      :title,
      :content,
      :read_at,
      images: []
    )
  end
end
