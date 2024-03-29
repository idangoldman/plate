module Slim
  class Dictionary < Filter
    def on_slim_output(escape, code, content)
      capture = code.match(/(?<method>^[a-z][a-z\.0-9_]+)(?:\((?<args>.*)\))?/i)
      code = replace_dots_with_i18n(code, capture) if I18n.exists?(capture[:method])

      LOG.info "
        ON_SLIM_OUTPUT
        ESCAPE:  #{escape.inspect}
        CODE:    #{code.inspect}
        CONTENT: #{content.inspect}
      "
      [:slim, :output, escape, code, compile(content)]
    end

    private

    def replace_dots_with_i18n(code, captured)
      captured => { method:, args: }

      if args.present?
        code.gsub "#{method}(#{args})", "I18n.t('#{method}', #{args})"
      else
        code.gsub method, "I18n.t('#{method}')"
      end
    end
  end
end

Slim::Engine.before Slim::Controls, Slim::Dictionary
