class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: :selection
  
  def home
  end
  
  def selection
  end
end
