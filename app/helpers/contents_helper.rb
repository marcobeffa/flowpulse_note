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
  # video
  def video_provider(content)
    url = content.video_url.to_s
    return "youtube" if url.include?("youtu")
    return "vimeo"   if url.include?("vimeo.com")
    return "wistia"  if url.include?("wistia")
    return "mux"     if url.include?("mux.com") || url.include?("stream.mux.com")
    "unknown"
  end

  def video_id(content)
    url = content.video_url.to_s
    case video_provider(content)
    when "youtube"
      uri = URI.parse(url) rescue nil
      return nil unless uri
      if uri.host.include?("youtu.be")
        uri.path[1..] # rimuove lo slash iniziale
      elsif uri.host.include?("youtube.com")
        CGI.parse(uri.query.to_s)["v"]&.first
      end
    when "vimeo"
      url[%r{vimeo\.com/(\d+)}, 1]
    when "wistia"
      url[%r{wistia\.com/medias/([^?\/]+)}, 1]
    when "mux"
      url[%r{stream\.mux\.com/([^?\/]+)}, 1]
    else
      nil
    end
  end

  def embed_url(content)
    url = content.video_url.to_s
    return nil if url.blank?

    if url.include?("youtu.be")
      id = URI.parse(url).path[1..] # es: /abc123 -> abc123
      "https://www.youtube.com/embed/#{id}"
    elsif url.include?("youtube.com")
      id = CGI.parse(URI.parse(url).query.to_s)["v"]&.first
      "https://www.youtube.com/embed/#{id}" if id
    else
      nil
    end
  end
end
