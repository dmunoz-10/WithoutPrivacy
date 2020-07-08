# frozen_string_literal: true

# Application Helper
module ApplicationHelper
  include Pagy::Frontend

  OPTIONS_MARKDOWN = %i[no_intra_emphasis tables fenced_code_blocks autolink
                        disable_indented_code_blocks strikethrough space_after_headers
                        superscript underline highlight quote footnotes
                        hard_wrap escape_html].freeze

  def markdown(text)
    html = Markdown.new(text, *OPTIONS_MARKDOWN).to_html
    wrap_mentions(html)
  end

  private

  def wrap_mentions(html)
    html.gsub!(/(@(?!.*\.\.)(?!.*\.$)[^\W][\w.]{0,29})+/) do
      if User.exists? username: Regexp.last_match(1)[1..]
        "<a href='/#{Regexp.last_match(1)[1..]}'>#{Regexp.last_match(1)}</a>"
      else
        Regexp.last_match(1)
      end
    end
    html.html_safe
  end
end
