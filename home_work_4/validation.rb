# frozen_string_literal: true

# Module for validation
module Validation
  def validate_by_regexp(element, regexp, msg)
    raise RegexpError, msg unless element.match?(regexp)
  end
end
