$ () ->
  { $, History, NProgress } = window

  $body = $ document.body
  $ajaxContainer = $ "#ajax-container"
  $latestPost = $ "#latest-post"
  $postIndex = $ "#post-index"

  loading = false
  showIndex = false
  loadPromise = null

  # Initially hide the index and show the latest post
  $latestPost.show()
  $postIndex.hide()

  # Show the index if the url has "page" in it (a simple
  # way of checking if we're on a paginated page.)
  if window.location.pathname.indexOf("page") is 1
    $latestPost.hide()
    $postIndex.show()

  # Check if history is enabled for the browser
  if not History.enabled
    false

  History.Adapter.bind window, "statechange", () ->
    state = History.getState()

    # Get the requested url and replace the current content
    # with the loaded content
    $.ajax(
      url: state.url,
      type: "get"
    ).then((result) ->
      $html = $ result
      $newContent = $html.find("#ajax-container").contents()

      $body.animate { scrollTop: 0 }

      $ajaxContainer.fadeOut 500, () ->
        $latestPost = $newContent.find "#latest-post"
        $postIndex = $newContent.find "#post-index"

        if showIndex
          $latestPost.hide()
        else
          $latestPost.show()
          $postIndex.hide()

        $ajaxContainer.html $newContent
        $ajaxContainer.fadeIn 500

        NProgress.done()

        loading = false
        showIndex = false
    , () ->
      NProgress.done()

      loading = false
      showIndex = false
    )

  $body.on "click", ".js-ajax-link, .pagination a", (e) ->
    e.preventDefault()

    if loading
      return

    $this = $ this

    currentState = History.getState()
    url = $this.attr "href"
    title = $this.attr "title"

    # If the requested url is not the current states url push
    # the new state and make the ajax call.
    if url isnt currentState.url
      loading = true

      # Check if we need to show the post index after we've
      # loaded the new content
      if $this.hasClass("js-show-index") or $this.parent(".pagination").length
        showIndex = true

      NProgress.start()
      History.pushState { salt: new Date().getTime() }, title, url
    else
      $body.animate { scrollTop: 0 }
      NProgress.start()

      # Swap in the latest post or post index as needed
      if $this.hasClass "js-show-index"
        $latestPost.fadeOut 300, () ->
          $postIndex.fadeIn 300
          NProgress.done()
      else
        $postIndex.fadeOut 300, () ->
          $latestPost.fadeIn 300
          NProgress.done()
