class CoursesController < ApplicationController
  before_action :require_admin, only: [:new, :create, :destroy, :update, :edit]
  skip_before_action :require_user
  
    def index
      @courses = Course.all
    end
    
    def new
      @course = Course.new(params[:id])
    end
    
    def show
      @course = Course.find(params[:id])
    end
  
    def edit
     @course = Course.find(params[:id])
    end
    
    def create
    @course = Course.new(course_params)
    if @course.save
     flash[:notice] = "You have successfully created a course!"
     redirect_to @course
    else
      render 'new'
    end
    end
  
  def update
     @course = Course.find(params[:id])
    if @course.update(course_params)
      flash[:notice] = "You have successfully updated your course"
     redirect_to @course
    else
      render 'edit'
    end
  end
  
  def destroy
     @course = Course.find(params[:id])
     @course.destroy
     flash[:danger] = "Your course have successfully deleted"
     redirect_to root_path
  end
  
  private
  
  def set_params
    @course = Course.find(params[:id]) 
  end
  
  def course_params
    params.require(:course).permit(:short_name, :name, :description )
  end
 
  def require_admin
    if logged_in? and !current_user.admin?
    flash[:danger] = "Only admin can perform that action"
    redirect_to root_path
    end
  end
end