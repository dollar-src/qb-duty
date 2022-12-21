
dollar = {}; 


$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27: // ESC
        dollar.CloseAyarMenu();
            break;
    }
});

dollar.CloseAyarMenu = function() {
    $(".Container").css({"display":"none"});
    $(".Container2").css({"display":"none"});






    $.post('https://qb-duty/CloseMenu:NuiCallback',JSON.stringify({data: true}));
};







window.addEventListener('message', function(event) {
    eFunc = event.data
    var item = event.data
    var fullname = item.fullname
    var ambulance = item.ambulance
    var police = item.police

    const box = document.getElementById('nametext');
    const box1 = document.getElementById('nametextp');
    const activepolice = document.getElementById('activenumber');
    const activeambulance = document.getElementById('activenumbere');

    box.textContent = fullname

    if (eFunc.action == "showui") {
      activepolice.textContent = police
      box1.textContent = fullname

        $(".Container").css({"display":"block"});
        $('body').show()


    } else if (eFunc.action == "hideui") {

        $("body").fadeOut(500)
        $(".Container").css({"display":"none"});

    } else if (eFunc.action == "showems") {
      activeambulance.textContent = ambulance


      $(".Container2").css({"display":"block"});
      $('body').show()
    }

    
    


})




    $(".dutyofftext").click(function() {
      $.post('https://src-duty/src-duty:dutyoffclient', JSON.stringify({}))
      dollar.CloseAyarMenu()
  })

  $(".dutyontext").click(function() {
    $.post('https://qb-duty/src-duty:dutyonclient', JSON.stringify({}))
    dollar.CloseAyarMenu()
})
