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

  def up_vote
    answer = Answer.find(params[:id])
    if answer.voted_by?(current_user, "up")
      answer.undo_up_vote_by(current_user)
    else
      answer.up_vote_by(current_user)
    end
    redirect_to answer.question, flash:{ success: "提交成功" }
  end
  def down_vote
    answer = Answer.find(params[:id])
    if answer.voted_by?(current_user, "down")
      answer.undo_down_vote_by(current_user)
    else
      answer.down_vote_by(current_user)
    end
    
    redirect_to answer.question, flash:{ success: "提交成功" }
  end

  private
    def answer_params
      params.require(:answer).permit(:content)
    end
end
