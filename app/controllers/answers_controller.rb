class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def index
    
  end
  def show
    
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
    redirect_to @question, flash: { success: "回答添加成功" }
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def answer_params
      params.require(:answer).permit(:content)
    end
end
