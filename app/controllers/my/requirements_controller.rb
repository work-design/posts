class My::RequirementsController < My::BaseController
  before_action :set_requirement, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}
    @requirements = Requirement.default_where(q_params).page(params[:page])
  end

  def new
    @requirement = current_user.requirements.build
  end

  def create
    @requirement = current_user.requirements.build(requirement_params)

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

  def pickup
    @rv = current_user.requirement_volunteers.find_or_initialize_by(requirement_id: params[:id])

    if @rv.save
      render 'pickup'
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
      :mobile,
      :from,
      :to,
      :pick_on,
      :pick_at,
      :note
    )
  end

end
