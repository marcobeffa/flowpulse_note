module ContentsHelper
  include Pagy::Frontend
  def rendered_body(body)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
    markdown = Redcarpet::Markdown.new(renderer,
                                       autolink: true,
                                       tables: true,
                                       fenced_code_blocks: true)
    markdown.render(body).html_safe
  end
end
