class SlackWebhooksController < ApplicationController 

  def create 
    render json: { text: "Some message you want to include" }
  end

end