class Jarmandy::ChallengesController < Jarmandy::BaseController
  def index
    @challenges = Challenge.all.includes(:category)
  end

  def new
    @challenge = Challenge.new
    @categories = Category.all.order(order: :asc)
  end

  def create
    p = params[:challenge]
    @challenge = Challenge.new
    @challenge.name = p[:name]
    @challenge.category_id = p[:category_id]
    @challenge.points = p[:points]
    @challenge.clue = p[:clue]
    @challenge.answer = p[:answer]

    if @challenge.save
      flash[:success] = "challenge #{@challenge.name} created"
      return redirect_to jarmandy_challenges_path
    else
      @categories = Category.all.order(order: :asc)
      return render action: 'new'
    end
  end

  def show
    @challenge = Challenge.find params[:id]
  end

  def edit
    @challenge = Challenge.find params[:id]
  end

  def update
    @challenge = Challenge.find params[:id]
  end
end
