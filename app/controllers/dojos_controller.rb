class DojosController < ApplicationController
  before_action :set_dojo, only: [:show, :update, :destroy]

  def index
    @dojos = Dojo.all 
    render json: @dojos, include: :senseis, status: :ok
  end

  def show
    render json: @dojo
  end

  def create
    @dojo = Dojo.new(dojo_params)
    
    if @dojo.save
      render json: @dojo, status: :created
    else
      render json: @dojo.errors, status: :unprocessable_entity
    end
  end

  def update
    if @dojo.update(dojo_params)
      render json: @dojo, status: :created
    else
      render json: @dojo.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @dojo.destroy
  end

  private

  def set_dojo
    @dojo = Dojo.find(params[:id])
  end

  def dojo_params
    params.require(:dojo).permit(:name, :motto)
  end
end
