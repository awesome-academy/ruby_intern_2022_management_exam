class SubjectsController < ApplicationController
  def show
    @pagy, @subject = pagy Subject.search(params[:search]),
                           items: Settings.subject.item
    respond_to do |format|
      format.js
      format.html
    end
  end
end
