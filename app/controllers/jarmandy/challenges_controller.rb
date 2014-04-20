class Jarmandy::ChallengesController < Jarmandy::BaseController
  helper_method :categories, :challenge
  def index
    @challenges = Challenge.all.includes(:category)
  end

  def new
  end

  def create
    p = params[:challenge]
    challenge.name = p[:name]
    challenge.category_id = p[:category_id]
    challenge.points = p[:points]
    challenge.clue = p[:clue]
    challenge.answer = p[:answer]

    if challenge.save
      flash[:success] = "challenge #{challenge.name} created"
      return redirect_to jarmandy_challenges_path
    else
      return render action: 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    p = params[:challenge]
    challenge.name = p[:name]
    challenge.category_id = p[:category_id]
    challenge.points = p[:points]
    challenge.clue = p[:clue]
    challenge.answer = p[:answer]

    if challenge.save
      flash[:success] = "challenge #{challenge.name} updated"
      return redirect_to jarmandy_challenge_path challenge
    else
      @categories = Category.all.order(order: :asc)
      return render action: 'edit'
    end
  end

  def unlock
    challenge.unlock!
    redirect_to jarmandy_challenge_path challenge
  end

  def lock
    challenge.lock!
    redirect_to jarmandy_challenge_path challenge
  end

  private
  def categories
    @categories ||= Category.all.order(order: :asc)
  end

  def challenge
    @challenge ||= Challenge.find params[:id]
  end
end
