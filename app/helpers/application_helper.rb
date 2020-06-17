# frozen_string_literal: true

# Application Helper
module ApplicationHelper
  include Pagy::Frontend

  OPTIONS_MARKDOWN = %i[no_intra_emphasis tables fenced_code_blocks autolink
                        disable_indented_code_blocks strikethrough space_after_headers
                        superscript underline highlight quote footnotes
                        hard_wrap filter_html no_images no_styles no_links].freeze

  def markdown(text)
    Markdown.new(text, *OPTIONS_MARKDOWN).to_html.html_safe
  end
end
