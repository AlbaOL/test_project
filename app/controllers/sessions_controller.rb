class SessionsController < Devise::SessionsController
    respond_to :json

    before_action :rewrite_param_names, only: [:create]

    def new
        render json: {response: "Authentication required"}, status: 401
    end

    def create
        self.resource = warden.authenticate!(auth_options)
        sign_in(resource_name, resource)
        yield resource if block_given?
        render json: {success: true,
                    response: "Authentication successful",
                    user: resource.attributes.merge(jwt: current_token)},
                status: 200
    end

    # api :POST, 'users/sign_out', 'logout'

    private

    def rewrite_param_names
        request.params[:user] = {email: request.params[:email], password: request.params[:password]}
    end

    def current_token
        request.env['warden-jwt_auth.token']
    end
end