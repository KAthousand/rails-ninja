class SenseisController < ApplicationController
  before_action :set_sensei, only: [:show, :update, :destroy]

  def index
    @dojo = Dojo.find(params[:dojo_id])
    @senseis = Sensei.where(dojo_id: @dojo.id)
    render json: @senseis, include: :dojo, status: :ok
  end

  def show
    render json: @sensei, include: :dojo, status: :ok
  end

  def create
    @dojo = Dojo.find(params[:id])
    @sensei = Sensei.new(sensei_params)
    @dojo.push(@sensei)
    if @sensei.save
      render json: @sensei, status: :created
    else
      render json: @sensei.errors, status: :unprocessable_entity
    end
  end

  def update
    if @sensei.update(sensei_params)
      render json: @sensei, status: :created
    else
      render json: @sensei.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @sensei.destroy
  end

  private

  def set_sensei
    @dojo = Dojo.find(params[:id])
    @sensei = Sensei.find(params[:id])
  end

  def sensei_params
    params.require(:sensei).permit(:name, :image_url, :wise_quote)
  end
end
