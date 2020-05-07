module ApplicationHelper
	def markdown(text)
		options = [:hard_wrap, :filter_html, :no_intra_emphasis, :autolink, :underline, :highlight, :quote, :tables, :lax_spacing]
		Markdown.new(text, *options).to_html.html_safe
	end
end
