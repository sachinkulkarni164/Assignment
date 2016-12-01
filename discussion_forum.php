<?php

if(isset($_POST['submit']) && isset($_POST['prevmsg'])){
	echo "<br />\n";
 echo "New Comment :".$_POST['message'];
 echo "<br />\n";
 echo " Previous Comment :".$_POST['prevmsg'];
 echo "<br />\n";
}
if(isset($_POST['submit']) && $_POST['submit']=='Submit'){
 $message=$_POST['message'];
 $name=$_POST["name"];
  echo $name."<br/>". $message;?>
 
 

 <html>
 <head>

 </head>
 <body>

<form method="POST" action="<?=$_SERVER["PHP_SELF"]?>">
 
    <br>Name:<input type="text" name="name" id="name">

    <br>Comment:<textarea name="message" id="message"></textarea>
        <input type="hidden" name="prevmsg" value="<?=$message?>"/>
    <br><input type="submit" name="submit" value="Submit"/>

   </form>
   </body>
   </html>
 <?php    
  }
  else {  
    ?>  
 <html>
 <head> 
 <h1>Discussion Board</h1> 
 </head>
 <body>

 <body bgcolor="F5FFFA">
 <form method="POST" action="<?=$_SERVER["PHP_SELF"]?>">
 

    <br>Name:<input type="text" name="name" id="name"> 

    <br>Comment:<textarea name="message" id="message"></textarea>

    <br><input type="submit" name="submit" value="Submit"/>

</form>
</body>
</html>
<?php } ?>
