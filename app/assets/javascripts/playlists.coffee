# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
    # Defines id of item that is currently playing 
    currentItemId = undefined

    # Bind click event to item thumbnails
    $('.yt_thumbnail').click -> window.makeVideoPlayer $(this).data('uid'), $(this).data('id')

    # Create YouTube player
    window.onYouTubePlayerAPIReady = ->
        window.player = new (YT.Player)('player',
            width: '640'
            height: '390'
            videoId: undefined
            events:
                onReady: onPlayerReady
                onStateChange: onPlayerStateChange)
        return

    # Autoplay video
    window.onPlayerReady = (event) ->
        $('.yt_thumbnail').first().click()
        return

    # When video ends
    window.onPlayerStateChange = (event) ->
        if event.data == YT.PlayerState.ENDED
            # Delete item from playlist
            $.ajax({
                url: window.location.href + '/items/' + currentItemId,
                type: 'DELETE',
                success: ->
                    # Remove deleted item
                    $('.yt_thumbnail').first().parent().remove()

                    # Play next item
                    $('.yt_thumbnail').first().click()
            });
        return

    # Play video when clicked on thumbnail
    # Exposed explicity so it can be accessed from items.coffee
    window.makeVideoPlayer = (video, id) ->
        player.loadVideoById(video, 0, "large")
        currentItemId = id
    return 
