class ImportsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @imports = Import.all
  end

  def new
    @import = Import.new
  end

  def create
    @import = Import.import(params[:import][:file_name].read, params[:import][:file_name].original_filename)

    redirect_to @import
  end

  def show
    @import = Import.find params[:id]
  end
end
