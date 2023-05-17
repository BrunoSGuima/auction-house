class QuestionsController < ApplicationController
  before_action :set_question, only: [:update, :hide, :show, :edit]
  before_action :set_auction_lot, only: [:new, :create]
  before_action :authenticate_user!, except: [:show]
  before_action :authenticate_admin!, only: [:update, :hide]
  before_action :check_user_status, only: [:create, :new]

  def index
    @questions = Question.all
  end

  def new
    @question = @auction_lot.questions.build
  end

  def show
  end
  

  def edit
  end

  def create
    @question = @auction_lot.questions.build(question_params)
    @question.user = current_user
    if @question.save
      redirect_to auction_lot_path(@question.auction_lot), notice: 'Pergunta feita com sucesso.'
    else
      redirect_to auction_lot_path(@auction_lot), alert: 'Não foi possível fazer a pergunta.'
    end
  end

  def update
    if response_params[:response_text].present?
      @question.admin_id = current_user.id
    end
    
    if @question.update(response_params)
      redirect_to questions_path, notice: 'Resposta enviada com sucesso.'
    else
      redirect_to questions_path, alert: 'Não foi possível enviar a resposta.'
    end
  end

  def hide
    if @question.update(visible: false)
        redirect_to questions_path, notice: 'Pergunta ocultada com sucesso.'
    else
        redirect_to questions_path, alert: 'Não foi possível ocultar a pergunta.'
    end
  end

  private

  def set_question
      @question = Question.find(params[:id])
  end

  def check_user_status
    if current_user.suspended?
      redirect_to @auction_lot, alert: 'Sua conta está suspensa.'
    end
  end

  def set_auction_lot
      @auction_lot = AuctionLot.find(params[:auction_lot_id])
  end

  def question_params
      params.require(:question).permit(:auction_lot_id, :question_text)
  end

  def response_params
      params.require(:question).permit(:response_text, :admin_id)
  end

  def authenticate_admin!
      redirect_to root_path, alert: 'Apenas administradores podem responder ou ocultar perguntas.' unless current_user.admin?
  end
end
