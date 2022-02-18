<!doctype html>
<html lang="th">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> 
    <title>Document</title> 
    <link rel="stylesheet" href="https://unpkg.com/bootstrap@4.5.0/dist/css/bootstrap.min.css" >
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css" >
</head>
<body>
   
   
<div class="container mt-5 mx-auto">
        <!-- <h2>ใช้วิธีการ Swap Type</h2>
        <input type="password" name="obj1" class="pass-swap">
        <button type="button" class="btn-toggle-pass">Show</button> -->
  
        <hr class="my-3">
        <h2>ใช้วิธีการ Swap Type กรณีใช้ร่วมกับ bootstrap และ fontawesome </h2>
        <div class="input-group mb-3">
            <input type="password" class="form-control pass-swap" placeholder="Password">
            <div class="input-group-append">
                <button class="btn btn-light">
                    <i class="fa fa-eye"></i>
                </button>
            </div>            
        </div>
  
  
</div>
  
<script src="https://unpkg.com/jquery@3.3.1/dist/jquery.min.js"></script>
<script src="https://unpkg.com/bootstrap@4.5.0/dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(function(){
    // ใช้วิธีการ สลับ type 
     $(document.body).on("click",".btn-toggle-pass",function(){
        let ele = $(this).prev(".pass-swap");
        let condCheck = $(this).text();
        $(this).text((condCheck=='Show')?'Hide':'Show');
        let swap_attr = (ele.attr("type")=="password")?"text":"password";
        console.log(ele.attr("type")); 
        ele.attr("type",swap_attr);
     });
  
     // กรณีใช้ร่วมกับ bootstrap และ fontawesome 
     $(document.body).on("click","[class*='fa-eye']",function(){
         $(this).toggleClass("fa-eye-slash fa-eye");  
         let ele = $(this).closest(".input-group-append").siblings(".pass-swap");
         let swap_attr = (ele.attr("type")=="password")?"text":"password";
         ele.attr("type",swap_attr);         
     });     
});
</script>
</body>
</html>