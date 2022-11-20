class TestsController < Simpler::Controller

  def index
    render plain: "SomeText #{Time.now}"
    #@time = Time.now
  end

  def create; end

end
