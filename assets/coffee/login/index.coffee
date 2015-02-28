$ ->
  $(".form").hAlign().vAlign()

  $(".form form").on "submit", (e)->
    e.preventDefault()
    e.stopPropagation()

    form = $(this)
    button = form.find(".button").val("sending...").removeClass "error"

    $.post form.attr("action"), form.serialize(), (response)->
      button.toggleClass "error", !response.success

      console.log response.success

      if response.success
        button.val("logging in now....")
        window.location.href = "/account"

      else
        button.val response.message
        form.find(".input").eq(1).val ""
