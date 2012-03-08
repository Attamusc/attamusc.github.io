$(document).ready(function () {
    $('.post-rect').each(function(index) {
        var self = this;
        $(this).on('click', function(e) {
            window.location = self.children[0].href;
        });
    });
});