class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        apartments = Apartment.all
        render json: apartments, status: :ok
    end

    def show
        apartment = Apartment.find_by(id: params[:id])
        render json: apartment, serializer: ApartmentWithTenantSerializer, status: :ok
    end

    def create
        apartment = Apartment.create!(apartment_params)
        render json: apartment, status: :created
    end

    def update
        apartment = Apartment.find_by(id: params[:id])
        apartment.update!(apartment_params)
        render json: apartment, status: :ok
    end

    def destroy
        apartment = Apartment.find_by(id: params[:id])
        apartment.destroy
        head :no_content
    end


    private

    def render_not_found_response
        render json: {error: "Apartment not found"}, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def apartment_params
        params.permit(:number)
    end
end