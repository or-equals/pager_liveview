defmodule PagerLiveView do
  @moduledoc """
    Documentation for `PagerLiveView`.
  """
  import Phoenix.LiveView.Helpers, only: [live_redirect: 2]
  import Phoenix.HTML, only: [sigil_E: 2]

  def pagination_text(results) do
    ~E"""
    <p class="text-sm text-gray-700">
      Showing
      <span class="font-medium"><%= results.first %></span>
      to
        <span class="font-medium"><%= results.last %></span>
        of
          <span class="font-medium"><%= results.count %></span>
          results
        </p>
    """
  end

  def pagination_route(conn, route, action, nil) do
    &route.(conn, action, page: &1)
  end

  def pagination_route(conn, route, action, param) do
    &route.(conn, action, param, page: &1)
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

  defp previous_link(route, results) do
    ~E"""
    <svg class="mt-2 w-5 h-5 inline text-gray-700" xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
      <path fill-rule="evenodd" d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z" clip-rule="evenodd" />
    </svg>
    <%= live_redirect("Previous page", to: route.(results.prev_page), class: "relative inline-flex items-center py-2 text-sm font-medium rounded-md text-gray-700 bg-warm-gray-100 hover:underline") %>
    """
  end

  defp next_link(route, results) do
    ~E"""
    <%= live_redirect("Next page", to: route.(results.next_page), class: "ml-6 relative inline-flex items-center py-2 text-sm font-medium rounded-md text-gray-700 bg-warm-gray-100 hover:underline") %>
    <svg class="mt-2 w-5 h-5 inline text-gray-700" xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
      <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
    </svg>
    """
  end
end
