class ConversationsController < ApplicationController
  before_filter :authenticate_user!
  helper_method :mailbox, :conversation

  def index
    # @tab_id = params[:tab]
    @conversations = current_user.mailbox.inbox.page(params[:inbox_page]).per(15)
    @conversations_sent = current_user.mailbox.sentbox.page(params[:sent_page]).per(15)
    @conversations_trash = current_user.mailbox.trash.page(params[:trash_page]).per(15)
  end

  def message
    @to_user = User.find(params[:id])

    render 'new'

  end

  def show
    conversation.mark_as_read(current_user)
    if !Appointment.find_by_conversation_id(conversation.id).nil?
      appointment = Appointment.find_by_conversation_id(conversation.id)
      redirect_to appointment_path(user_id:current_user.slug, id: appointment.id)
    end
  end

  def create
    recipient_ids = conversation_params(:recipients).split(',')
    recipients = User.where(slug: recipient_ids).all

    conversation = current_user.
      send_message(recipients, *conversation_params(:body, :subject)).conversation

    redirect_to conversation
  end

  def reply
    current_user.reply_to_conversation(conversation, *message_params(:body, :subject))
    redirect_to conversation
  end

  def trash
    conversation = Conversation.find(params[:id])
    conversation.move_to_trash(current_user)
    redirect_to :conversations
  end

  def untrash
    conversation.untrash(current_user)
    redirect_to :conversations
  end

  private

  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end

  def conversation_params(*keys)
    fetch_params(:conversation, *keys)
  end

  def message_params(*keys)
    fetch_params(:message, *keys)
  end

  def fetch_params(key, *subkeys)
    params[key].instance_eval do
      case subkeys.size
      when 0 then self
      when 1 then self[subkeys.first]
      else subkeys.map{|k| self[k] }
      end
    end
  end
end