module Presenter
  class Base
    include Lexiconic
    include Grammar

    alias tpl template
    alias partial template
    def template( basename, & )
      Utils.render_template( basename, self, & )
    end

    def class_if( condition, class_name )
      condition ? class_name : nil
    end
  end
end
