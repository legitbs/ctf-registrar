class ChallengeCheevo
  def initialize(solution, controller)
    @solution = solution
    @controller = controller
  end

  def process!
    return unless @solution.persisted?

    award_first_blood
    check_category_starting
    check_category_clearing
  end

  private
  def award_first_blood
    cheevo 'FIRST BLOOD'
  end

  def check_category_starting
    cheevo "Baby's First" if @solution.challenge.category.name == "Baby's First"
  end

  def check_category_clearing
    cat = @solution.challenge.category
    chals = cat.challenges
    solns = chals.map{ |c| c.solutions.where(team_id: team.id).all }
    cleared = !solns.any?(&:empty?)

    return unless cleared

    cheevo case cat.name
           when "Baby's First"
             "Baby's Last"
           when "Vito Genovese"
             "Associate"
           when "Gynophage"
             "To Devour"
           when "Selir"
             "Dragon Warrior"
           when "HJ"
             "Up in the woods"
           when "Duchess"
             "Codename: Duchess"
           when "Lightning"
             "Strikes Twice"
           when "Sirgoon"
             "Knighthood"
           end

    check_category_first_clearing
  end

  def check_category_first_clearing
    cat = @solution.challenge.category
    chals = cat.challenges
    solns = chals.map{ |c| c.solutions.all.length }
    first = solns.min == 1

    return unless first

    cheevo case cat.name
           when "Vito Genovese"
             "Consigliere"
           when "Gynophage"
             "Patient Zero"
           when "Selir"
             "Be Aggressive"
           when "HJ"
             "Building a Still"
           when "Duchess"
             "Eggs 101"
           when "Lightning"
             "Air War"
           when "Sirgoon"
             "Goonhood"
           end
  end

  def user
    @user ||= @controller.current_user
  end

  def team
    @team ||= @solution.team
  end

  def flash
    @flash ||= @controller.flash
  end

  def cheevo(name)
    achievement = Achievement.where(name: name).first
    award = @solution.team.awards.create(
                                         achievement: achievement,
                                         user: @controller.current_user)

    if award.persisted?
      flash[:cheevo] ||= []
      flash[:cheevo] << award.id
    end
  rescue => e
    Rails.logger.warn "Lost cheevo #{name.inspect} for user #{user.id} on team #{team.id} :( #{e.inspect}"
    return
  end
end
