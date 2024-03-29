module Slim
  class Dictionary < Filter
    def on_slim_output(escape, code, content)
      capture = code.match(/(?<method>^[a-z][a-z\.0-9_]+)(?:\((?<args>.*)\))?/i)

      if capture && I18n.exists?(capture[:method])
        code = "I18n.t('#{capture[:method]}')"

        if capture[:args]
          code = code.gsub(")", ", #{capture[:args]})")
        end
      end

      $LOG.info """
        ON_SLIM_OUTPUT
        ESCAPE:  #{escape.inspect}
        CODE:    #{code.inspect}
        CONTENT: #{content.inspect}
      """
      [:slim, :output, escape, code, compile(content)]
    end
  end
end

Slim::Engine.before Slim::EndInserter, Slim::Dictionary
