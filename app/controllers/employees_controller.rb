class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  # GET /employees
  # GET /employees.json
  def index
    @employees = Employee.paginate(:page => params[:page], :per_page => 20).where(:published => true)
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
    set_employee
  end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
    set_employee
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)
    @employee.published = true

    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: 'El Articulo a sido creado.' }
        format.json { render action: 'show', status: :created, location: @employee }
      else
        format.html { render action: 'new' }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update

    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: 'El contacto a sido actualizado.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee.published = false
    @employee.save

    respond_to do |format|
      format.html { redirect_to employees_url }
      format.json { head :no_content }
    end
  end

  def search
    # @employees =  Employee.where(["name LIKE :tag", {:tag => params[:search][:employee_name]}])
    @employees =  Employee.find(:all, :conditions => ['name LIKE ?', "%#{params[:search][:employee]}%"])
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
      #@categories = EmployeeCategory.find(:all)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:name, :address, :phone, :rfc, :email, :published)
    end
end
