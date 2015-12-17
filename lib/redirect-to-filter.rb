class RedirectToFilter < Nanoc::Filter
  identifier :redirect_to
  type :text

  def run(content, params = {})
    return content unless params[:redirect_to]
    NanocRedirector.redirect_template(params[:redirect_to])
  end
end
