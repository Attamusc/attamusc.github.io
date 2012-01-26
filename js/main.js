(function($) {
    $('section').hide();
    
    $('a').click(function(e) {
        e.preventDefault();
        
        var fade_in_id = $(this).attr('href'),
            fade_out_id = $('.active > a').attr('href');
            
        console.log(fade_in_id);
        console.log(fade_out_id);
        
        $('.active').removeClass('active');
        $(this).parent().addClass('active');
        
        $(fade_out_id).fadeOut("normal", function() {
            $(fade_in_id).fadeIn("normal");
        });
    });
    
    $('#intro').show();
})(jQuery);