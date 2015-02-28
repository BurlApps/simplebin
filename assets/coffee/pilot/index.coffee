$ ->
  new google.maps.places.Autocomplete $(".input.address").get 0
  $('.input.cvc').payment "formatCardCVC"
  $('.input.expiration').payment "formatCardExpiry"
  $('.input.card').payment "formatCardNumber"
  $(".form").on "submit", (e)->
    e?.preventDefault()
    e?.stopPropagation()

    form = $(this)
    button = form.find(".button").removeClass("error").val "sending..."

    $.post "/pilot", form.serialize(), (response)=>
      if response.success
        form.find(".input").val ""
        button.val "Sign Up!"

      else
        button.addClass("error").val(response.message)
