class PickerController < ApplicationController
  before_filter :require_hot_team

  def choice
    @counts = Category.for_picker
  end
end
