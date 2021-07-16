class Api::V1::LicensesController < ApplicationController
  before_action :authenticate_user!
  require 'csv'

  def read_license_file
    begin
      csv_text = File.read(params[:file])
      csv = CSV.parse(csv_text, :headers => true, header_converters: :symbol)
      csv.each do |row|
        License.create!(row.to_hash)
      end
      render json: "File received!", status: 200
    rescue => exception
      render json: exception.message, status: 400
    end
  end

  def print_license
    begin
      #Ideally licenses and users needs a reference for this POC license will be harcoded
      # license = License.where(user: current_user)
      license = License.first
      render json: PdfService.generate(license), status: 200
    rescue => exception
      render json: exception.message, status: 400
    end
  end

  private

  def license_params
    params.permit(:rider_id, :rider_name, :ba_email, :rider_license_id, :sex, :rider_birth_date, :expiration_date)
  end

  def license
    @license ||= License.find(params[:id])
  end
end
