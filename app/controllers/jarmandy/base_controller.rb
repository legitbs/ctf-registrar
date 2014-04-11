class Jarmandy::BaseController < ApplicationController
  before_filter :require_legitbs
end