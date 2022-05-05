# frozen_string_literal: true

def get_timestamp(params = {})
  stamp = ''
  %i[minute hour date month weekday].each do |k|
    stamp += "#{params[k] || '*'} "
  end
  stamp.strip
end
