class NotesController < ApplicationController
  before_filter :get_notes
  before_filter :get_note_by_id, :only => [:destroy, :create_or_update_note]
  
  def index
    @note = Note.new
    @user = User.new
    
    respond_to do |format|
      format.html
      format.js { render :action => "index" }
    end
  end

  def destroy
    @note_id = @note.id
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url, :notice => "Successfully destroyed note." }
      format.js
    end
  end
  
  def create_or_update_note
    if @note.nil?
      create
    else
      update
    end
  end
  
  private
  
    def update
      #redirect_to notes_url if @note.nil?

      if @note.update_attributes(params[:note])
        notice = "Successfully updated note."
      else
        notice = "Could not update note. Try later or refresh."
      end

      respond_to do |format|
        format.html { redirect_to notes_url, :notice => notice }
        format.js { render :action => "update" }
      end
    end

    def create
      @note = Note.new(params[:note])
      if user_signed_in?
        @note.user_id = current_user.id
      else
        @note.token = get_existing_or_generate_new_token
      end
      @note.save
      respond_to do |format|
        format.html { redirect_to notes_url, :notice => "Successfully created note." }
        format.js { render :action => "create" }
      end
    end
  
    def get_note_by_id
      if user_signed_in?
        @note = current_user.notes.find(params[:id])
      else
        @note = Note.find_by_id_and_token(params[:id], get_existing_or_generate_new_token)
      end
    end
  
    def get_notes
      if user_signed_in?
        @notes = current_user.notes.order("created_at DESC").page params[:page]
      else
        @notes = Note.where(:token => get_existing_or_generate_new_token).order("created_at DESC").page params[:page]
      end
      @notes ||= []
    end

end
