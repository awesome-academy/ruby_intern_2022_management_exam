class Admin::SubjectsController < AdminController
  before_action :load_subject, only: %i(edit update destroy)

  def index
    @pagy, @subjects = pagy Subject.all, items: Settings.subject.admin_item
  end

  def new
    @subject = Subject.new
    render "_subject_form"
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:success] = t ".success"
      redirect_to admin_subjects_path
    else
      flash[:danger] = t ".fail"
      render "_subject_form"
    end
  end

  def edit
    render "_subject_form"
  end

  def update
    if @subject.update subject_params
      flash[:success] = t ".success"
      redirect_to admin_subjects_path
    else
      flash[:danger] = t ".fail"
      render "_subject_form"
    end
  end

  def destroy
    if @subject.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to admin_subjects_path
  end

  private

  def subject_params
    params.require(:subject).permit Subject::SUBJECT_PARAMS
  end
end
