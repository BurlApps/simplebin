$ ->
  enablePosting = true

  $(".form").on "submit", (e)->
    e.preventDefault()
    e.stopPropagation()

    if enablePosting
      form = $(this)
      button = form.find(".button").val("sending...")
      enablePosting = false

      $.post form.attr("action"), form.serialize(), (response)->
        button.toggleClass "error", !response.success
        button.toggleClass "active", response.success

        if response.success
          button.val "logging in now...."
          window.location.reload()
        else
          enablePosting = true
          button.val response.message
          form.find("input[type=password]").val ""
