class Statdump
  include Singleton

  def sass_engine
    return @sass_engine if defined? @sass_engine

    root = Rails.root.join('app/assets/stylesheets/statdump.css.sass').to_s
    load = ['.', File.dirname(root)]
    @sass_engine = Sass::Engine.for_file(root, load_paths: load, template_location: File.dirname(root))
  end

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
