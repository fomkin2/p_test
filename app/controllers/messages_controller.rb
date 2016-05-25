class MessagesController < ApplicationController
  load_and_authorize_resource
  layout 'admin'

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to "/联系我们", flash: { message_delivered: '您的留言已发出，感谢您宝贵的时间。' }
    else
      redirect_to "/联系我们", flash: { message_undelivered: '发送失败，请正确填写。' }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:name, :email, :title, :content)
    end
end
