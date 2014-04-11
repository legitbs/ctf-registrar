class Jarmandy::BaseController < ApplicationController
  before_filter :require_legitbs
  layout 'jarmandy'
end