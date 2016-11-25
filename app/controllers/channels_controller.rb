class ChannelsController < ApplicationController
  # GET /channels
  def index
    @channels = Channel.all

    render json: @channels
  end

  # GET /channels/1
  def show
    @channel = Channel.find_by(slug: params[:id])
    render json: @channel
  end

  # POST /channels
  def create
    @channel = Channel.new(channel_params)

    if @channel.save
      render json: @channel, status: :created, location: @channel
    else
      render json: @channel.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /channels/1
  def update
    @channel = Channel.find(params[:id])
    if @channel.update(channel_params)
      render json: @channel
    else
      render json: @channel.errors, status: :unprocessable_entity
    end
  end

  # DELETE /channels/1
  def destroy
    @channel = Channel.find(params[:id])
    @channel.destroy
  end

  private
    # Only allow a trusted parameter "white list" through.
    def channel_params
      params.require(:channel).permit(:name, :slug)
    end
end
