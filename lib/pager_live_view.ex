defmodule PagerLiveView do
  @moduledoc """
    Documentation for `PagerLiveView`.
  """
  import Phoenix.LiveView.Helpers, only: [live_redirect: 2]
  import Phoenix.Component, only: [sigil_H: 2]

  def pagination_text(assigns) do
    ~H"""
    <p class="text-sm text-gray-700">
      Showing
      <span class="font-medium"><%= @first %></span>
      to
        <span class="font-medium"><%= @last %></span>
        of
          <span class="font-medium"><%= @count %></span>
          results
        </p>
    """
  end

  def pagination_route(conn, route, action, nil) do
    &route.(conn, action, page: &1)
  end

  def pagination_route(conn, route, action, param) do
    &route.(conn, action, Map.merge(param, %{page: &1}))
  end

  def pagination_links(conn, results, route, action, param \\ nil) do
    route = pagination_route(conn, route, action, param)
    %{has_prev: has_prev, has_next: has_next} = results
    has_both = has_prev && has_next

    links = links(action, results, route, has_prev, has_both, has_next)

    Enum.filter(links, & &1)
  end

  defp links(_, results, route, has_prev, has_both, has_next) do
    [
      has_prev && previous_link(route, results),
      has_both && "",
      has_next && next_link(route, results)
    ]
  end

  defp previous_link(route, assigns) do
    ~H"""
    <%= live_redirect("Previous", to: route.(@prev_page), class: "relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50") %>
    """
  end

  defp next_link(route, assigns) do
    ~H"""
    <%= live_redirect("Next", to: route.(@next_page), class: "ml-3 relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50") %>
    """
  end
end
