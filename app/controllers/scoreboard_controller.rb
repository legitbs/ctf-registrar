class ScoreboardController < ApplicationController
  before_action :require_on_team, except: %i(index ctftime complete)
  before_action :require_during_game, except: %i(index ctftime complete)
  before_action :require_during_or_after_game, only: %i(index)

  layout 'scoreboard'

  def index
    return anonymous_index unless current_team

    @leaderboard = Team.for_scoreboard current_team
    @categories = Category.for_scoreboard
    @challenges = Challenge.for_scoreboard current_team

    respond_to do |f|
      f.html
      f.json {
        render json: {
          leaderboard: @leaderboard
        }
      }
    end
  end

  def complete
    @leaderboard = Team.entire_scoreboard
  end

  def ctftime
    @leaderboard = Team.entire_scoreboard
  end

  def challenge
    @challenge = Challenge.find params[:id]
    @title = @challenge.name
    @solution = current_team.solution_for @challenge
    @histogram = @challenge.solution_histograms.order(end_time: :asc)

    return redirect_to scoreboard_path if @challenge.locked? && !legitbs_cookie?

    cheevo "ack"
    @challenge.view! current_user

    respond_to do |f|
      f.html
      f.json do
        render json: {
                 category: @challenge.category,
                 challenge: @challenge,
                 solution: @solution
               }
      end
    end
  end

  def answer
    @challenge = Challenge.find params[:id]
    @solution = current_team.solution_for @challenge

    sticky_situation = @challenge.locked? || @solution.created_at
    correct = @challenge.correct_answer?(params[:answer]) rescue false

    logbuf = [
      "ANSWER ATTEMPT",
      current_team.inspect,
      current_user.inspect,
      @challenge.inspect,
      params[:answer]
    ]

    if sticky_situation
      logbuf << 'STICKY SITUATION'
    elsif !correct
      REDIS.publish('wrong', {
                      team: current_team.as_redis,
                      challenge: @challenge.as_json({  }),
                      category: @challenge.category.as_json,
                      wrong_answer: params[:answer],
                    }.to_json) rescue nil
      logbuf << "WRONG ANSWER"
    end

    if sticky_situation || !correct
      Rails.logger.info logbuf.join(' ')
      return respond_to do |f|
        f.html do
          flash[:error] = "Wrong answer."
          redirect_to challenge_path(@challenge.id)
        end
        f.json { render status: 400, json: {
          error: "Now that's what I call a sticky situation.",
          wrong: !correct,
          weird: sticky_situation
         }}
      end
    end

    logbuf << "RIGHT ANSWER"

    hot = nil
    @solution.transaction do
      hot = @challenge.solve!
      @solution.save

      if hot
        cheevo "Pop it & unlock it"
        logbuf << "OMG HOT"
        current_team.reload.update_attribute :hot, true

        message = { kind: 'popped',
                    user: current_user,
                    team: current_team,
                    challenge: @challenge
                  }
        SlackbotJob.perform_later message
        PushbulletJob.perform_later message
        PushoverJob.perform_later message
        TwitterJob.perform_later message

        n = Notice.new
        n.body = "#{current_team.name} solved #{@challenge.name} [#{@challenge.category.name}] for #{@challenge.points} points."
        n.save
      else
        n = Notice.new
        n.body = "Your teammate #{current_user.username} solved #{@challenge.name} [#{@challenge.category.name}] for #{@challenge.points} points."
        n.team = current_team
        n.save
      end
    end

    respond_to do |f|
      f.html {
        return redirect_to choice_path if hot
        return redirect_to scoreboard_path
      }

      f.json {
        render status: 200, json: {
          woot: 'you got it',
          hot: hot
        }
      }
    end

    Rails.logger.info logbuf.join(' ')
  end

  private
  def anonymous_index
    @leaderboard = Team.anonymous_scoreboard
    @categories = Category.for_scoreboard
    @challenges = Challenge.for_scoreboard Team.find 1

    respond_to do |f|
      f.html
      f.json {
        render json: {
          leaderboard: @leaderboard
        }
      }
    end
  end
end
