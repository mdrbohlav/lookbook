module Lookbook
  class Code::Component < Lookbook::BaseComponent
    include Lookbook::OutputHelper

    def initialize(
      source: nil,
      language: :html,
      line_numbers: false,
      highlight_lines: [],
      start_line: 1,
      wrap: false,
      theme: nil,
      dark: false,
      full_height: false,
      **html_attrs
    )
      @source_code = source
      @highlight_opts = {
        language: language,
        line_numbers: line_numbers,
        highlight_lines: highlight_lines,
        start_line: start_line
      }
      @highlight_lines = highlight_lines
      @wrap = wrap
      @theme = theme
      @dark = dark
      @full_height = full_height
      super(**html_attrs)
    end

    def theme_classname
      "theme-#{@theme.to_s.tr("_", "-")}"
    end

    def source
      (@source_code || content).strip_heredoc.strip
    end

    def numbered?
      @highlight_opts[:line_numbers] == true
    end

    def focussed?
      @highlight_opts[:highlight_lines].any?
    end

    def full_height?
      @full_height
    end

    def is_dark?
      @dark
    end

    def before_render
      @theme ||= (config.code_options && config.code_options[:theme]&.to_sym) || :github
      @dark ||= ActiveModel::Type::Boolean.new.cast((config.code_options && config.code_options[:dark]) || false)
    end

    protected

    def alpine_component
      "codeComponent"
    end
  end
end
