defmodule PagerLiveViewTest do
  use ExUnit.Case
  doctest PagerLiveView

  test "greets the world" do
    assert %Phoenix.LiveView.Rendered{static: _static} = PagerLiveView.pagination_text(%{first: "first", last: "last", count: "count"})
  end
end
