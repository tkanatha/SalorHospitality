class SeasonsController < ApplicationController
  def index
    @seasons = @current_vendor.seasons.existing
  end

  def new
    @season = Season.new
  end

  def create
    @season = Season.new(params[:season])
    @season.vendor = @current_vendor
    @season.company = @current_company
    if @season.save
      redirect_to seasons_path
    else
      render(:new)
    end
  end

  def edit
    @season = Season.accessible_by(@current_user).existing.find_by_id(params[:id])
    render :new
  end

  def update
    @season = Season.accessible_by(@current_user).existing.find_by_id(params[:id])
    redirect_to seasons_path and return unless @season
    @season.update_attributes(params[:season]) ? redirect_to(seasons_path) : render(:new)
  end

  def destroy
    @season = Season.accessible_by(@current_user).existing.find_by_id(params[:id])
    redirect_to seasons_path and return unless @season
    @season.update_attribute :hidden, true
    redirect_to seasons_path
  end
end