
$(window).ready(function(){
    $('#context2').hide();

    $('#aa').click(function(){
        $('#context2').hide();
        $('#context1').show();
    })
    $('#bb').click(function(){
        $('#context1').hide();
        $('#context2').show();
    })
})


