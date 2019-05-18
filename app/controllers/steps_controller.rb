class StepsController < ApplicationController

  def new
    @step = Step.new
  end

  def create
    steps = params[:id]
    if steps.empty?
      flash[:danger] = 'Cannot submit empty field.'
    else
      add_steps(steps)
      redirect_to "/recipes/#{params[:id]}"
    end
  end

  def add_steps(id)
    params.each do |param|
      Step.create(description: param[1]['description'], recipe_id: id)
    end
  end
end
