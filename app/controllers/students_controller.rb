class StudentsController < ApplicationController
  before_action :set_sensei, only: [:show, :update, :destroy]

  # /GET all
  def index
    @dojo = Dojo.find(params[:dojo_id])
    @sensei = Sensei.find(params[:sensei_id])
    @students = Student.where(sensei_id: @sensei.id)
    render json: @students, :include => {:sensei => {:include => :dojo}}
  end

  # /Get one
  def show
    render json: @student, include: :sensei, status: :ok
  end

  def create
    @dojo = Dojo.find(params[:id])
    @sensei = Sensei.find(params[:id])
    @student = Student.new(student_params)
    @sensei.push(@student)
    if @student.save
      render json: @student, status: :created
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  def update
    if @student.update(student_params)
      render json: @student, status: :created
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @student.destroy
  end

  private

  def set_sensei
    @dojo = Dojo.find(params[:id])
    @sensei = Sensei.find(params[:id])
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:sensei).permit(:name, :age, :special_attack)
  end
end
