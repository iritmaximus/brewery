class StylesController < ApplicationController
  def show
    @style = Style.find params[:id]
  end

  def index
    @styles = Style.all
  end

  def new
    @style = Style.new
  end

  def edit
    @style = Style.find params[:id]
  end

  def create
    @style = Style.new(style_params)

    respond_to do |format|
      if @style.save
        format.html { redirect_to style_url(@style), notice: "Style was successfully created." }
        format.json { render :show, status: :created, location: @style }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @style.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @style = Style.find params[:id]
    respond_to do |format|
      if @style.update(style_params)
        format.html { redirect_to style_url(@style), notice: "Style was successfully updated." }
        format.json { render :show, status: :ok, location: @style }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @style.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /breweries/1 or /breweries/1.json
  def destroy
    @style.destroy

    respond_to do |format|
      format.html { redirect_to styles_url, notice: "Style was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def style_params
    params.require(:style).permit(:name, :description)
  end
end
