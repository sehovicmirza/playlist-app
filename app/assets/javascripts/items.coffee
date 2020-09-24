# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
    # Add click handler for Add new item modal
    $('#add_item_submit').click -> addNewItem $("#new_item_link").val()

    # Creates new item
    addNewItem = (link) -> 
        route = window.location.href + '/items/';

        # Validate YouTube link
        if (link != undefined && link != '') 
            regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=|\?v=)([^#\&\?]*).*/;
            match = link.match(regExp);
            uid = match[2];
            if (match && uid.length == 11) 

                # Store item to database
                $.ajax({
                    url:  route,
                    method: 'POST',
                    data: {ytlink: link},
                    success: (item) -> 
                        item.route = route
                        # TODO: Figure out how to render views/items/_item.html.slim instead of this
                        item_elt = buildItemElement item;
                        $("#items_wrapper").append(item_elt);
                        $(".yt_thumbnail").last().click -> window.makeVideoPlayer uid, item.id
                        $(".alert").append(buildSuccessAlert "New item is successfully added to the list")
                    error: (error) -> 
                        $(".alert").append(buildErrorAlert error.responseJSON.message)
                });

            else 
                $(".alert").append(buildErrorAlert "Provided YouTube link is invalid")
        else
            $(".alert").append(buildErrorAlert "Unable to add empty value")

        $("#addItemModal").modal('hide');

        
    # TODO: Refactor this
    buildItemElement = (item) ->
        itemElement = '<div id="wrapper"><div id="item"><p>' + item.title + '</p>' +
                    '<img src="' + item.thumbnail_url + '" class="yt_thumbnail"/>' +
                    '<p> Votes: ' + item.rank + '</p></div>' +
                    '<div id="voting"><a rel="nofollow" data-method="post" class="btn btn-success" href="' + item.route + item.id + '/votes"> Add vote </a><br>' +
                    '<a rel="nofollow" data-method="delete" class="btn btn-warning" href="' + item.route + item.id + '/votes"> Remove vote </a>' +
                    '</div></div><hr align="left">';
        return itemElement;

    # TODO: Refactor this
    buildErrorAlert = (msg) ->
        errorAlert = '<div class="alert alert-danger">' +
                    '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>' +
                    '<strong>Error: </strong>' + msg + '</div>';
        return errorAlert;

     # TODO: Refactor this
    buildSuccessAlert = (msg) ->
        successAlert = '<div class="alert alert-success">' +
                     '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>' +
                     '<strong>Success! </strong>' + msg + '</div>';
        return successAlert;
