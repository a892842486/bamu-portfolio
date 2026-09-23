class WelcomeController < ApplicationController
  def index
    @profile = Profile.first
    @projects = Project.all
  end
end
