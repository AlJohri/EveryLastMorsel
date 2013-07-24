module PostsHelper

	def simple_format2(text, html_options = {}, options = {})
	  wrapper_tag = options.fetch(:wrapper_tag, :p)

	  text = sanitize(text) if options.fetch(:sanitize, true)
	  paragraphs = split_paragraphs2(text)

	  if paragraphs.empty?
	    content_tag(wrapper_tag, nil, html_options)
	  else
	    paragraphs.map { |paragraph|
	      content_tag(wrapper_tag, paragraph, html_options, options[:sanitize])
	    }.join("\n\n").html_safe
	  end
	end

    def split_paragraphs2(text)
      return [] if text.blank?

      text.to_str.gsub(/\r\n?/, "\n").split(/\n+/).map! do |t|
        t.gsub!(/([^\n]\n)(?=[^\n])/, '\1<br />') || t
      end
    end


end
