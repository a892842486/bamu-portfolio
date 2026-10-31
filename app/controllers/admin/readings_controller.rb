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
      @reading.images.attach(params[:reading][:images]) if params[:reading][:images].present?

      redirect_to admin_readings_path, notice: "文章新增成功。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @reading.update(reading_params)
      @reading.images.attach(params[:reading][:images]) if params[:reading][:images].present?

      params[:reading][:remove_image_ids]&.each do |image_id|
        image = @reading.images.find(image_id)
        image.purge
      end

      redirect_to admin_readings_path, notice: "文章更新成功。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @reading.destroy
    redirect_to admin_readings_path, notice: "文章刪除成功。"
  end

  def backup
    backup_dir = Rails.root.join("db", "reading_notes")
    readings_file = backup_dir.join("readings.json")

    readings = Reading.ordered

    data = readings.map do |reading|
      filename = "#{reading.title}.md"

      images = reading.images.each_with_index.map do |image, index|
        extension = File.extname(image.filename.to_s)
        "images/#{reading.title}-#{format('%02d', index + 1)}#{extension}"
      end

      {
        title: reading.title,
        file: filename,
        read_at: reading.read_at,
        images: images
      }
    end

    readings_file.write(
      JSON.pretty_generate(data)
    )

    readings.each do |reading|
      # 備份文章文字
      filename = "#{reading.title}.md"
      markdown_file = backup_dir.join(filename)

      markdown_file.write(reading.content)

      # 備份文章圖片
      images_dir = backup_dir.join("images")
      FileUtils.mkdir_p(images_dir)

      reading.images.each_with_index do |image, index|
        extension = File.extname(image.filename.to_s)
        image_filename = "#{reading.title}-#{format('%02d', index + 1)}#{extension}"
        image_file = images_dir.join(image_filename)

        image_file.binwrite(image.download)
      end
    end

    redirect_to admin_readings_path, notice: "Reading 備份成功。"
  end

  private

  def set_reading
    @reading = Reading.find(params[:id])
  end

  def reading_params
    params.require(:reading).permit(
      :title,
      :content,
      :read_at
    )
  end
end
