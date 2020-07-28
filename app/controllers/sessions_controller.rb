class SessionsController < Devise::SessionsController
  respond_to :json

  private
  def respond_with(resource, _opts = {})
    # this was returning the user object, we don't need that
    # render json: resource
    render json: {}, status: 204
  end

  def respond_to_on_destroy
    head :ok
  end
end
