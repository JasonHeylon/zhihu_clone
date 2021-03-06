class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy, :follow, :unfollow]
  before_action :authenticate_user!, except: [:show, :index]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.latest
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @question.inc(viewed_count: 1)
  end

  # GET /questions/new
  def new
    @question = current_user.questions.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = current_user.questions.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, flash: { success: '问题已经成功创建.' } }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, flash: { success: '问题已经成功更新.' } }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    if @question.user == current_user
      @question.destroy
      respond_to do |format|
        format.html { redirect_to questions_url, flash: { success: '成功删除问题.' } }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to :back, flash: { success: '删除失败,只能删除自己的问题.' } }
        format.json { render json: @question, status: :unprocessable_entity }
      end
    end
  end


  def follow
    @question.follow_by(current_user.id)
    respond_to do |format|
      format.html { redirect_to @question, flash: {success: '关注成功' } }
      format.json { @question }
    end
  end

  def unfollow
    @question.unfollow_by(current_user.id)
    respond_to do |format|
      format.html { redirect_to @question, flash: { success: '取消关注成功' } }
      format.json { @question }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title, :description)
    end
end
