// This javascript file simply handles the very basic functionality to
// handle the user interactions on the Card Shuffler page.
$(document).ready( function() {

    // Concatenate all the card data values
    // into a single comma separated string.
    function collectCardData() {
        var data = "";

        $(".card").each(function() {
           data += "," + $(this).data().card;
        });

        // Remove the first comma.
        data = data.substring(1);

        return data;
    }

    // Handle a user's click on a shuffle button.
    $(".shuffle-button").on("click", function(e) {
        var shuffleSlug = $(e.currentTarget).data().shuffle,
            cardData    = collectCardData(),
            queryString = "deck=" + cardData,
            url         = "/shuffle/" + shuffleSlug + "?" + queryString;

        window.location = url;
    });
});