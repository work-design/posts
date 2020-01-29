class Admin::RequirementsController < Admin::BaseController
  before_action :set_requirement, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}
    q_params.merge! params.permit(:name)
    @requirements = Requirement.order(id: :desc).page(params[:page])
  end

  def new
    @requirement = Requirement.new
  end

  def create
    @requirement = Requirement.new(requirement_params)

    unless @requirement.save
      render :new, locals: { model: @requirement }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @requirement.assign_attributes(requirement_params)

    unless @requirement.save
      render :edit, locals: { model: @requirement }, status: :unprocessable_entity
    end
  end

  def destroy
    @requirement.destroy
  end

  private
  def set_requirement
    @requirement = Requirement.find(params[:id])
  end

  def requirement_params
    params.fetch(:requirement, {}).permit(
      :name,
      :from,
      :to,
      :pick_on,
      :pick_at,
      :note,
      :user_id,
      :volunteer_id
    )
  end

end
