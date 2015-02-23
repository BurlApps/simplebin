$ ->
  config.questionTracker = 0
  config.questionsLength = $(".questions .question").length - 1
  config.form = {}
  config.active = false
  activateQuestion(config.questionTracker)

  new google.maps.places.Autocomplete $(".input.address").get 0
  $('.input.cvc').payment "formatCardCVC"
  $('.input.expiration').payment "formatCardExpiry"
  $('.input.credit-card').payment("formatCardNumber").keyup cardCheck
  $('.radio').on "click", radioClicked
  $(".questions .question").on "submit", questionSubmitted
  $(".footer").on "click", ".next:not(.share)", submitForm

submitForm = (e)->
  e.preventDefault()
  e.stopPropagation()

  $(".questions .question")
    .eq(config.questionTracker)
    .submit()

radioClicked = ->
  $(this)
    .parents(".question")
    .find(".input")
    .val($(this).val())

questionSubmitted = (e)->
  e.preventDefault()
  e.stopPropagation()

  input = $(this).find(".input")
  name = input.attr "name"
  value = input.val()

  if config.active && value != ""
    config.active = false
    config.form[name] = if value != "null" then value else null
    $(".questions .question").fadeOut 250

    if config.questionTracker is 0
      $(".questions .question")
        .eq(1)
        .find("span")
        .text input.val()

    setTimeout ->
      activateQuestion(++config.questionTracker)

      if config.questionTracker is config.questionsLength
        $.post "/register", config.form

        url = "https://www.facebook.com/dialog/share?"
        url += "app_id=357660074421114&"
        url += "display=page&"
        url += "href=#{config.host}#{location.pathname}&"
        url += "redirect_uri=#{config.host}"

        $(".footer .next")
          .text("Share")
          .addClass("share")
          .attr
            href: url
            target: "_blank"
    , 275

activateQuestion = (question)->
  config.active = true
  $(".questions .question")
    .eq(question)
    .fadeIn(250)
    .find(".input")
    .attr("placeholder", "")
    .eq(0)
    .focus()

  percentage = Math.ceil((question/config.questionsLength) * 100)
  percentage = Math.min(percentage, 100)
  $(".footer .progress span").text("(#{percentage})")
  $(".footer .progress .bar").width("#{percentage}%")

cardCheck = ->
  type = $.payment.cardType $(@).val()

  if type and type != "Unknown"
    $(".question .card-type")
    .attr("src", "/img/cards/#{type.toLowerCase().replace(" ", "")}.png")
    .load ->
      $(".question .card-type").fadeIn 200
  else
    $(".question .card-type").fadeOut 200
