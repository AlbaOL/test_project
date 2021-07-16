class ApplicationController < ActionController::API
    def render_resource(resource)
        if resource.errors.empty?
          render json: resource
        else
          validation_error(resource)
        end
    end
    
    def validation_error(resource)
        render json: {
            errors: [
            {
                status: '400',
                title: 'Bad Request',
                detail: resource.errors,
                code: '100'
            }
            ]
        }, status: :bad_request
    end

    def authorize_api
        res = request.env["HTTP_AUTHORIZATION"].present? ? authorized_request? : false
        return unless res == false

        render json: { message: 'You are not authorized to do this action' }, status: 401
    end

    protected
    
    def authorized_request?
        token = request.env["HTTP_AUTHORIZATION"].split[1]
        begin
            decoded_token = JWT.decode token, ENV["DEVISE_JWT_SECRET_KEY"], true, algorithm: 'HS256'
            payload = decoded_token.first
            AuthToken.find_by(payload: payload).present? ? true : false
        end
    end
end
