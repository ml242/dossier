fbKey = 762893740391021

getFacebookEvents = ->
  FB.api "/me/events", (response) ->
    console.log(response)
    if response and not response.error
      i = 0
      while i < response.data.length
        $fbEvent = $("<div>")
        $fbEvent.addClass "fb-event-item"
        $fbEvent.text response.data[i].name
        $fbEvent.attr "data-facebook-id", response.data[i].id
        $("body").append $fbEvent
        i++

getFacebookEventInfo = (eventId) ->
  FB.api "/" + eventId, (response) ->
    if response and not response.error
      console.log(response)

getFacebookPicture = (fbResponse) ->
  $.ajax
    url: "http://graph.facebook.com/" + fbResponse.id + "/picture?type=large&redirect=false&width=400&height=400"
    type: 'GET'
    success: (response) =>
      $aTag = $('<a>')
      $aTag.addClass('image-wrapper')

      $('<span>')
        .addClass('image-text')
        .html("<h1>#{fbResponse.name}</h1><br /><h2>I like boobs</h2>")
        .appendTo($aTag)

      $('<img>')
        .attr('src', response.data.url)
        .addClass('attendee')
        .appendTo($aTag)

      $('body').append($aTag)


getFacebookEventAttendees = (eventId) ->
  FB.api "/" + eventId + '/attending', (response) ->
    if response and not response.error
      for i in [0...response.data.length]
        getFacebookPicture(response.data[i])


jQuery ->

  $('body').prepend('<div id="fb-root"></div>')

  ((d, s, id) ->
    js = undefined
    fjs = d.getElementsByTagName(s)[0]
    return  if d.getElementById(id)
    js = d.createElement(s)
    js.id = id
    js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=" + fbKey
    fjs.parentNode.insertBefore js, fjs
  ) document, "script", "facebook-jssdk"

  $.ajax
    url: "#{window.location.protocol}//connect.facebook.net/en_US/all.js"
    dataType: 'script'
    cache: true

    window.fbAsyncInit = ->

      # setTimeout ->
      #   getFacebookEvents()
      # , 1000

      $('body').on 'click', '.fb-sign-in', (e) ->
        e.preventDefault()
        FB.login ((response) ->
          
          window.location = '/auth/facebook/callback' + '?' + $.param({ signed_request: response.authResponse.signedRequest }) if response.authResponse), scope: "email, user_birthday, user_likes, user_location, user_events"

      $('body').on 'click', '.fb-sign-out', (e) ->
        FB.getLoginStatus (response) ->
          FB.logout() if response.authResponse
        true

      # $('body').on 'click', '.fb-event-item', (e) ->
      #   eventId = $(this).attr('data-facebook-id')
      #   getFacebookEventInfo(eventId)
      #   getFacebookEventAttendees(eventId)

      $('.events-selector').on 'change', (e) ->
        eventId = $('.events-selector').find(":selected").val();
        getFacebookEventInfo(eventId)
        getFacebookEventAttendees(eventId)


