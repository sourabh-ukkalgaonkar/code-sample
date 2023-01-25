# frozen_string_literal: true

module Api
  module V1
    # API to classify and check the data.
    class MobsterController < ApplicationController
      before_action :set_classifier_service

      def classify
        @classifier_service.train(data: classify_params[:data])

        render json: { success: true, message: 'Data has been trained successfully' }, status: :ok
      rescue ClassifierService::ClassifierServiceError => e
        render json: { success: false, message: e.message }, status: :unprocessable_entity
      end

      def check
        response = @classifier_service.check(query: params[:query])

        render json: { success: true, message: 'Classification has been found', classification: response }, status: :ok
      rescue ClassifierService::ClassifierNotFoundError => e
        render json: { success: false, message: e.message }, status: :not_found
      rescue ClassifierService::ClassifierServiceError => e
        render json: { success: false, message: e.message }, status: :unprocessable_entity
      end

      private

      def classify_params
        params.permit(data: [:category_name, { values: [] }])
      end

      def set_classifier_service
        @classifier_service = ClassifierService.new
      end
    end
  end
end
