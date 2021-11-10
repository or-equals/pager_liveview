defmodule PagerLiveViewTest do
  use ExUnit.Case
  doctest PagerLiveView

  test "greets the world" do
    assert {:safe, _ } = PagerLiveView.pagination_text(%{first: "first", last: "last", count: "count"})
  end
end
