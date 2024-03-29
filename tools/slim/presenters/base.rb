class PresenterBase
  def initialize( i18n_base_path: "" )
    @base_path = i18n_base_path
  end

  def t( key, options = {} )
    I18n.t( scoped( key ), options )
  end

  def l( key, options = {} )
    I18n.l( scoped( key ), options )
  end

  private

  def scoped( key )
    @base_path.empty? ? key : "#{@base_path}.#{key}"
  end
end
