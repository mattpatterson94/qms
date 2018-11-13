defmodule Qms.UriHelper do
  def add_param(host, param_name, param_value, concatenator \\ "&") do
    "#{host}#{concatenator}#{param_name}=#{param_value}"
  end
end
