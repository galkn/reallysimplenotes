class NotesController < ApplicationController
  before_filter :get_notes, :except => [:show]
  
  def index
    @note = Note.new
    @user = User.new
    
    respond_to do |format|
      format.html
      format.js { render :action => "index" }
    end
  end

  def show
    @note = Note.find(params[:id])
  end

  def destroy
    if user_signed_in?
      @note = current_user.notes.find(params[:id])
      @note_id = @note.id
      @note.destroy
      respond_to do |format|
        format.html { redirect_to notes_url, :notice => "Successfully destroyed note." }
        format.js
      end
    else
      @local_note_id_to_destroy = params[:id]
      respond_to do |format|
        format.html { redirect_to notes_url, :notice => "Could not destroy note locally. Please sign up or enable Javascript in your browser." }
        format.js { render :action => "destroy_locally" }
      end
    end
  end

  def update
    if user_signed_in?
      @note = Note.find(params[:id])
      if @note.update_attributes(params[:note])
        redirect_to notes_url, :notice  => "Successfully updated note."
      else
        redirect_to notes_url, :notice  => "Could not update note. Try later or refresh."
      end
    else
    end
  end

  def create
    @note = Note.new(params[:note])
    if user_signed_in?
      @note.user_id = current_user.id
      if @note.save
        respond_to do |format|
          format.html { redirect_to notes_url, :notice => "Successfully created note." }
          format.js
        end
      else
        respond_to do |format|
          format.html { render :action => 'index' }
          format.js { render :action => "create_fail" }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to notes_url, :notice => "Could not save note locally. Please sign up or enable Javascript in your browser." }
        format.js { render :action => "create_locally" }
      end
    end
  end
  
  private
  
    def get_notes
      @notes = []
      @notes = current_user.notes.order("created_at DESC").page params[:page] if user_signed_in?
    end

end
