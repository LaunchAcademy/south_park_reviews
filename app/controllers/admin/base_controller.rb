class Admin::BaseController < ApplicationController
  before_action do
     authorize_admin!(user)
   end
end
