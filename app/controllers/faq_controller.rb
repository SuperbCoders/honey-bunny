class FAQController < ApplicationController

  # GET /faq
  def index
    @page = Page.published.find_by(slug: 'faq')
    @faqs = FAQ.all
    @items = Item.not_deleted
    @question = Question.new
    @question.init_by_user(current_user)
  end
end
