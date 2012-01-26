(function($) {
    //$('section').hide();
    
    $('li > a').click(function(e) {
        e.preventDefault();
        
        var fade_in_id = $(this).attr('href'),
            fade_out_id = $('.active > a').attr('href');
            
        console.log(fade_in_id);
        console.log(fade_out_id);
        
        $('.active').removeClass('active');
        $(this).parent().addClass('active');
        
        window.location = fade_in_id;
        
        $(fade_out_id).fadeOut("normal", function() {
            $(fade_in_id).fadeIn("normal");
        });
    });
    
    var active_section = window.location.hash === "" ? "#intro" : window.location.hash;
    
    $("[href=" + active_section + "]").parent().addClass('active');
    $(active_section).fadeIn("normal");
})(jQuery);