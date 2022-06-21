class Admin::QuestionsController < AdminController
  before_action :find_question, only: %i(edit update destroy)

  def index
    @pagy, @questions = pagy Question.includes(:subject).sort_by_date
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new question_params
    if @question.save
      flash[:success] = t ".message_success"
      redirect_to admin_questions_path
    else
      flash[:danger] = t ".message_fail"
      render :new
    end
  end

  def edit; end

  def update
    if @question.update question_params
      flash[:success] = t ".message_success"
      redirect_to admin_questions_path
    else
      flash[:danger] = t ".message_fail"
      render :edit
    end
  end

  def destroy
    if @question.destroy
      flash.now[:success] = t ".message_success"
      respond_to do |format|
        format.js
        format.html
      end
    else
      flash[:danger] = t ".message_fail"
      redirect_to admin_questions_path
    end
  end

  private
  def find_question
    @question = Question.find_by id: params[:id]
    return if @question

    redirect_to admin_questions_path
    flash[:danger] = t ".no_question"
  end

  def question_params
    params.require(:question).permit Question::QUESTION_PARAMS
  end
end
