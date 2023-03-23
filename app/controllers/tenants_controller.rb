class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        tenants = Tenant.all
        render json: tenants, status: :ok
    end

    def show
        tenant = Tenant.find_by(id: params[:id])
        render json: tenant, serializer: TenantWithApartmentSerializer, status: :ok
    end

    def create
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created
    end

    def update
        tenant = Tenant.find_by(id: params[:id])
        tenant.update!(tenant_params)
        render json: tenant, status: :ok
    end

    def destroy
        tenant = Tenant.find_by(id: params[:id])
        tenant.destroy
        head :no_content
    end


    private

    def render_not_found_response
        render json: {error: "Apartment not found"}, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def tenant_params
        params.permit(:name, :age)
    end
end