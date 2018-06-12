class XlsxExportsHookListener < Redmine::Hook::ViewListener
  render_on :view_layouts_base_html_head, :inline => "<%= stylesheet_link_tag('xlsx_export' , :plugin => :xlsx_export) %>"
end
