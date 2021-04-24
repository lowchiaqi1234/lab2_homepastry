<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;


require '/home8/lowtancq/public_html/s270964/PHPMailer-master/src/Exception.php';
require '/home8/lowtancq/public_html/s270964/PHPMailer-master/src/PHPMailer.php';
require '/home8/lowtancq/public_html/s270964/PHPMailer-master/src/SMTP.php';


include_once("dbconnect.php");

$name = $_POST['username'];
$email = $_POST['email'];
$newotp = rand(1000,9999);
$newpass = random_password(10);
$passha = sha1($newpass);

$sqlupdate = "UPDATE tbl_user SET user_name ='$name',otp = '$newotp', password = '$passha' WHERE user_email = '$email'";
  if ($conn->query($sqlupdate) === TRUE){
    echo 'success';
    sendEmail($newotp,$newpass,$email);
  }else{
    echo "failed";
  }

function sendEmail($otp,$newpass,$email){
    $mail = new PHPMailer(true);
    $mail->SMTPDebug = 0;                      //Enable verbose debug output
    $mail->isSMTP();                                               //Send using SMTP
    $mail->Host       = 'mail.lowtancqx.com';                     //Set the SMTP server to send through
    $mail->SMTPAuth   = true;                                   //Enable SMTP authentication
    $mail->Username   = 'homepastry@lowtancqx.com';                     //SMTP username
    $mail->Password   = '6BDTQbEjj;PQ';                               //SMTP password
    $mail->SMTPSecure = 'tls';         //Enable TLS encryption; `PHPMailer::ENCRYPTION_SMTPS` encouraged
    $mail->Port       = 587;     
    
    $from = "homepastry@lowtancqx.com";
    $to = $email;
    $subject = "From Home Pastry. Reset your password";
    $message = "<p>Your account has been reset. Please login again using the information below.</p><br><h3>Password:".$newpass.
    "</h3><br><a href='https://lowtancqx.com/s270910/homepastry/php/verity_account.php?email=".$email."&key=".$otp."'>Click Here to activate account</a>";
    
    $mail->setFrom($from,"Home Pastry");
    $mail->addAddress($to);                                             //Add a recipient
    
    //Content
    $mail->isHTML(true);                                                //Set email format to HTML
    $mail->Subject = $subject;
    $mail->Body    = $message;
    $mail->send();
}

function random_password($length){
    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $password = '';
    $characterListLength = mb_strlen($characters,'8bit') - 1;
    foreach(range(1,$length)as$i){
        $password .=$characters[rand(0,$characterListLength)];
    }
    return $password;
}
?>