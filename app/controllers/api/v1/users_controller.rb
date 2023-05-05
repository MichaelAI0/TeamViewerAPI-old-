# frozen_string_literal: true

module Api
  module V1
    # Handles endpoints related to users
    class UsersController < Api::V1::ApplicationController
      before_action :authenticate_request, except: %i[login create]

      def login
        result = TeamApi::Auth.login(params[:email], params[:password])
        unless result.success?
          render_error(errors: "User not authenticated", status: 401) and return
        end

        payload = {
          user: UserBlueprint.render_as_hash(result.payload[:user], view: :login),
          status: 200
        }
        render_success(payload: payload)
      end
#TODO: Lee - this is happening here
      def logout
        if current_user.present?
          result = TeamApi::Auth.logout(@current_user, current_token)
          unless result.success?
            render_error(errors: "There was a problem logging out", status: 401) and return
          end

          # Invalidate the token by deleting it from the database
          current_token.destroy

          render_success(payload: "You have been logged out", status: 200)
        else
          render_error(errors: "Unauthorized", status: 401)
        end
      end

      def create
        result = TeamApi::Users.new_user(user_params)
        unless result.success?
          render_error(errors: "There was a problem creating a new user", status: 400) and return
        end
        payload = {
          user: UserBlueprint.render_as_hash(result.payload, view: :normal)
        }
        
        render_success(payload: payload, status: 201)
      end

      def me
        render_success(payload: UserBlueprint.render_as_hash(@current_user), status: 200)
      end

      def update
        result = TeamApi::Users.update_user(@current_user.id, user_params)
        unless result.success?
          render_error(errors: "There was a problem updating the user", status: 400) and return
        end
        payload = {
          user: UserBlueprint.render_as_hash(result.payload, view: :normal)
        }
        render_success(payload: payload, status: 200)
      end

      def validate_invitation
        user = User.invite_token_is(params[:invitation_token]).invite_not_expired.first

        if user.nil?
          render_error(errors: { validated: false, status: 401 }) and return
        end

        render_success(payload: { validated: true, status: 200 })
      end

      private

      def user_params
        params.permit(:first_name, :last_name, :email, :phone)
      end

      def render_success(payload:, status: :ok)
        render json: { success: true, payload: payload }, status: status
      end
    end
  end
end
