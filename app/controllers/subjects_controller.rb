class SubjectsController < ApplicationController
  authorize_resource

  def index
    @search = Subject.ransack(params[:search])
    @pagy, @subjects = pagy @search.result,
                            items: Settings.subject.item
    respond_to do |format|
      format.js
      format.html
    end
  end
end
