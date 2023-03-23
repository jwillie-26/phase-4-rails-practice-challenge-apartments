class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        leases = Lease.all
        render json: leases, status: :ok
    end

    def show
        lease = Lease.find_by(id: params[:id])
        render json: lease, status: :ok
    end

    def create
        lease = Lease.create!(lease_params)
        render json: lease, status: :created
    end

    def update
        lease = Lease.find_by(id: params[:id])
        lease.update!(lease_params)
        render json: lease, status: :ok
    end

    def destroy
        lease = Lease.find_by(id: params[:id])
        lease.destroy
        head :no_content
    end


    private

    def render_not_found_response
        render json: {error: "Apartment not found"}, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def lease_params
        params.permit(:rent)
    end
end