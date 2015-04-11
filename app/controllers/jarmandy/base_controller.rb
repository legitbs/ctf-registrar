class Jarmandy::BaseController < ApplicationController
  before_filter :require_legitbs
  layout 'jarmandy'

  PER_PAGE = 25
end
