class TestsController < Simpler::Controller

  def index
    #render plain: "SomeText #{Time.now}"
  end

  def show
    @params = params
    render plain: "SomeText #{@params}"
  end

  def create; end

end
