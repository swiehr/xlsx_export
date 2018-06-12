class XlsxExportsController < ApplicationController
  unloadable

  layout 'admin'

  def index
    @exports = XlsxExport.all
    respond_to do |format|
      format.html {}
      if MY_FEATURE[:gem_axlsx]
        format.xlsx {
          render filename: 'exports.xlsx'
        }
      end
    end
  end

  def new
    @export = XlsxExport.new
  end

  def create
    @export = XlsxExport.new(export_params)
    if @export.save
      redirect_to xlsx_exports_path
    else
      render 'new'
    end
  end

  def edit
    @export = XlsxExport.find(params[:id])
  end

  def update
    @export = XlsxExport.find(params[:id])
    if @export.update(export_params)
      redirect_back_or_default xlsx_exports_path
    else
      render 'edit'
    end
  end

  private 
  def export_params
    @all_attributes = XlsxExport.column_names.map(&:to_sym)
    @not_permitted = [:id]
    @extra_parameters = []
    params.require(:xlsx_export).permit(@all_attributes + @extra_parameters - @not_permitted)
  end
end
