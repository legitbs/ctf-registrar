module Jarmandy::BaseHelper
  def pagination_controls
    return '' unless @show_pagination

    @pagination_controls ||= content_tag :ul, class: 'pagination' do
      @pages.times.map do |n|
        content_tag :li do
          options = {page: n + 1, only: params[:only]}
          options.delete :page if options[:page] == 1
          link_to_unless_current(n + 1, params.merge(options))
        end
      end.join.html_safe
    end
  end
end
