class ContactsController < ApplicationController
  def show
    @profile = Profile.first
  end
end
