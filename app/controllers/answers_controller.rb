class AnswersController < ApplicationController

    def create 
        @question = Question.find params[:question_id]
        @new_answer = Answer.new answer_params
        @new_answer.user = current_user
        @new_answer.question = @question
        if @new_answer.save
            redirect_to question_path(@question)
        else
            @answers = @question.answers.order(created_at: :desc)
            render 'questions/show'
        end
    end

    def destroy 
        @answer = Answer.find(params[:id])
        if can? :crud, @answer
            @answer.destroy 
            redirect_to question_path(@answer.question)
        else
            redirect_to root_path, alert: 'Not Authorized' 
        end
    end

    private

    def answer_params
        params.require(:answer).permit(:body)
    end

end
