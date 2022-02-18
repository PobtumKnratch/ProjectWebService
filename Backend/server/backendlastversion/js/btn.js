/*!
    * Start Bootstrap - SB Admin v7.0.4 (https://startbootstrap.com/template/sb-admin)
    * Copyright 2013-2021 Start Bootstrap
    * Licensed under MIT (https://github.com/StartBootstrap/startbootstrap-sb-admin/blob/master/LICENSE)
    */
    // 
// Scripts
// 

document.getElementById("demo").onclick = function () {
    myFunction();
  };



  function myFunction() {
    document.getElementById("demo").innerHTML = "edit_food.php?update_id=<?php echo $row['id']; ?>";
  }