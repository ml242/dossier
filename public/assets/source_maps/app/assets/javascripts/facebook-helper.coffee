fbKey = 762893740391021
muKey = omj5dcb538pauaf06fs7pc7888

getFacebookEvents = ->
  FB.api "/me/events", (response) ->
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
      # console.log(response)
      # console.log("that's the response in the picture stuff ^^^")

      $aTag = $('<a>')
      $aTag.addClass('image-wrapper')

      $('<span>')
        .addClass('image-text')
        .addClass('invisible')
        .html("<h1>#{fbResponse.name}</h1><br /><h2>I like your app.</h2>")
        .appendTo($aTag)

      $('<img>')
        .attr('src', response.data.url)
        .addClass('attendee')
        .appendTo($aTag)

      $('.event-container').append($aTag)


getFacebookEventAttendees = (eventId) ->
  FB.api "/" + eventId + '/attending', (peepResponse) ->
    if peepResponse and not peepResponse.error
      for i in [0...peepResponse.data.length]
        getFacebookPicture(peepResponse.data[i])


setRSVP = (eventId, RSVPstatus) ->
  FB.api "/#{eventId}/#{RSVPstatus}", 'post', (response) ->
    if response == true
      $('.container').fadeOut(1000)
      window.location = "/"

setRSVP = (eventId, RSVPstatus) ->
  FB.api "/#{eventId}/#{RSVPstatus}", 'post', (response) ->
    if response == true
      $('.container').fadeOut(1000)
      window.location = "/"

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

      $('body').on 'click', '.fb-sign-in', (e) ->
        e.preventDefault()
        FB.login ((response) ->
          
          window.location = '/auth/facebook/callback' + '?' + $.param({ signed_request: response.authResponse.signedRequest }) if response.authResponse), scope: "email, user_birthday, user_likes, user_location, user_events, rsvp_event"

      $('body').on 'click', '.mu-sign-in', (e) ->
        e.preventDefault()
        $.ajax
          url: "https://api.meetup.com/oauth/request/" + muKey


      $('body').on 'click', '.fb-sign-out', (e) ->
        FB.getLoginStatus (response) ->
          FB.logout() if response.authResponse
        true

      $('.events-selector').on 'change', (e) ->
        $('.event-container').html('')
        eventId = $('.events-selector').find(":selected").val()
        getFacebookEventInfo(eventId)
        getFacebookEventAttendees(eventId)

      $('.events-invited-selector').on 'change', (e) ->
        $('.event-container').html('')
        eventId = $('.events-invited-selector').find(":selected").val()
        getFacebookEventInfo(eventId)
        getFacebookEventAttendees(eventId)

      $('.change-rsvp-selector').on 'change', (e) ->
        RSVPstatus = $(this).val()
        eventId = $('.events-selector').val()
        setRSVP(eventId, RSVPstatus)

      $('.set-rsvp-selector').on 'change', (e) ->
        RSVPstatus = $(this).val()
        eventId = $('.events-invited-selector').val()
        setRSVP(eventId, RSVPstatus)
