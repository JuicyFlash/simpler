class TestsController < Simpler::Controller

  def index
    headers['Content-Type'] = 'text/plain'
    # render plain: "SomeText #{Time.now}"
  end

  def create; end

end
