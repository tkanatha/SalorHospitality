# coding: UTF-8

# BillGastro -- The innovative Point Of Sales Software for your Restaurant
# Copyright (C) 2012-2013  Red (E) Tools LTD
# 
# See license.txt for the license applying to all files within this software.

class OptionsController < ApplicationController
  def index
    @categories = Category.accessible_by(@current_user).existing
  end

  def new
    @option = Option.new
    @categories = Category.accessible_by(@current_user).existing
  end

  def create
    @categories = Category.accessible_by(@current_user).existing
    @option = Option.new(params[:option])
    @option.save ? redirect_to(options_path) : render(:new)
  end

  def edit
    @categories = Category.accessible_by(@current_user).existing
    @option = Option.find(params[:id])
    render :new
  end

  def update
    @categories = Category.accessible_by(@current_user).all
    @option = Option.find(params[:id])
    success = @option.update_attributes(params[:option])
    success ? redirect_to(options_path) : render(:new)
  end

  def destroy
    @option = Option.find(params[:id])
    @option.update_attribute :hidden, true
    redirect_to options_path
  end

  def sort
    params['option'].each do |id|
      o = Option.find_by_id id
      o.position = params['option'].index(o.id.to_s) + 1
      o.save
    end
    render :nothing => true
  end

end
