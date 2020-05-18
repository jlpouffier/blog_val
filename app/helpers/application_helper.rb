require 'redcarpet'
require 'redcarpet/render_strip'

module ApplicationHelper
	def markdown(text)
		options = [:hard_wrap, :filter_html, :no_intra_emphasis, :autolink, :underline, :highlight, :quote, :tables, :lax_spacing]
		Markdown.new(text, *options).to_html.html_safe
	end

	def no_markdown(text)
		markdown = Redcarpet::Markdown.new(Redcarpet::Render::StripDown)
		markdown.render(text)
	end
end