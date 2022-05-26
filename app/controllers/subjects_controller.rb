class SubjectsController < ApplicationController
  def index
    @pagy, @subjects = pagy Subject.search(params[:name]),
                            items: Settings.subject.item
    respond_to do |format|
      format.js
      format.html
    end
  end
end
