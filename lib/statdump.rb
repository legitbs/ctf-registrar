class Statdump
  include Singleton

  def layout_engine
    @layout_engine ||= Haml::Engine.new File.read Rails.root.join 'app/views/layouts/statdump.html.haml'
  end

  def template_engine(template_name)
    @template_engine ||= Hash.new
    @template_engine[template_name] ||= 
      Haml::Engine.new File.read Rails.root.join "app/views/statdump/#{template_name}.html.haml"
  end

  def render(template, presenter)
    layout_engine.render do
      template_engine(template).render presenter
    end
  end
end
