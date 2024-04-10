module Presenter
  class Base
    include Preparable
    include Lexiconic

    def initialize( i18n_base_path: "" )
      @base_path = i18n_base_path
    end

    def template( basename, & )
      Utils.render_template( basename, self, & )
    end

    def class_if( condition, class_name )
      condition ? class_name : nil
    end
  end
end
