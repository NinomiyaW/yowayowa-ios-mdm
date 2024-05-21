class Api::V1::DevicesController < ApplicationController
  def index
    render json: { status: 200, devices: Device.all, message: "success" }
  end

  def create
    device = Device.new(device_params)
    if device.save
      render json: { status: 200, device: device, message: "success" }
    else
      render json: { status: 500, message: "error" }
    end
  end

  def destroy
    device = Device.find(params[:id])
    if device.destroy
      render json: { status: 200, message: "success" }
    else
      render json: { status: 500, message: "error" }
    end
  end

  private

  def device_params
    params.require(:device).permit(:device_name, :device_information)
  end
end
