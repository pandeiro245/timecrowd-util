class TasksController < ApplicationController
  protect_from_forgery :except => :create
  def create
    render text: Task.new.hy(params)
  end
end

