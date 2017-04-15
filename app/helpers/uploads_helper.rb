module UploadsHelper
  def challenge_picker(form_builder)
    challenges = Challenge.
                   joins(:category).
                   order(name: :asc).
                   all

    opts = { selected: params[:challenge_id] }

    form_builder.select(:challenge_id,
                        challenges.map do |c|
                          ["#{c.name} (#{c.category.name})",
                           c.id]
                        end,
                        opts)
  end
end
