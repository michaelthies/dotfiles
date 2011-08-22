class Object
  def im(include_super=false)
    self.class.instance_methods(include_super).sort
  end

  def imgrep(regex=nil, include_super=false)
    im(include_super).grep(regex).sort
  end
end

if ENV['RAILS_ENV']
  load File.dirname(__FILE__) + '/.railsrc'
end
