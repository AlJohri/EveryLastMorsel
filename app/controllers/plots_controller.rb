class PlotsController < ApplicationController
  layout "plots"
  
  # GET users/1/plots
  # GET users/1/plots.json
  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @plots = @user.plots

      respond_to do |format|
        format.html # index.html.erb
        format.json { render :json => @plots }
      end
    else
      @plots = Plot.all
      respond_to do |format|
        format.html { render :layout => 'application'}
        format.json { render :json => @plots }
      end
    end
  end

  # GET users/1/plots/1
  # GET users/1/plots/1.json
  def show
    if params[:user_id]
      @user = User.find(params[:user_id])
      @plot = @user.plots.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render :json => @plot }
      end
    else
      @plot = Plot.find(params[:id])
      respond_to do |format|
        format.html { render :layout => 'application'}
        format.json { render :json => @plot }
      end
    end
  end

  # GET users/1/plots/new
  # GET users/1/plots/new.json
  def new
    @user = User.find(params[:user_id])
    @plot = @user.plots.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @plot }
    end
  end

  # GET users/1/plots/1/edit
  def edit
    @user = User.find(params[:user_id])
    @plot = @user.plots.find(params[:id])
  end

  # POST users/1/plots
  # POST users/1/plots.json
  def create
    @user = User.find(params[:user_id])
    @plot = @user.plots.build(params[:plot])

    respond_to do |format|
      if @plot.save
        format.html { redirect_to([@plot.user, @plot], :notice => 'Plot was successfully created.') }
        format.json { render :json => @plot, :status => :created, :location => [@plot.user, @plot] }
      else
        format.html { render :action => "new" }
        format.json { render :json => @plot.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT users/1/plots/1
  # PUT users/1/plots/1.json
  def update
    @user = User.find(params[:user_id])
    @plot = @user.plots.find(params[:id])

    respond_to do |format|
      if @plot.update_attributes(params[:plot])
        format.html { redirect_to([@plot.user, @plot], :notice => 'Plot was successfully updated.') }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @plot.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE users/1/plots/1
  # DELETE users/1/plots/1.json
  def destroy
    @user = User.find(params[:user_id])
    @plot = @user.plots.find(params[:id])
    @plot.destroy

    respond_to do |format|
      format.html { redirect_to user_plots_url(user) }
      format.json { head :ok }
    end
  end
end
