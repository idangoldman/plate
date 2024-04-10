module Localable
  def self.included( base )
    base.extend( LocalableMethods )
  end

  module LocalableMethods
  end
end
