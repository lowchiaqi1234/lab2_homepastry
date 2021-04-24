<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;


require '/home8/lowtancq/public_html/s270910/PHPMailer-master/src/Exception.php';
require '/home8/lowtancq/public_html/s270910/PHPMailer-master/src/PHPMailer.php';
require '/home8/lowtancq/public_html/s270910/PHPMailer-master/src/SMTP.php';


include_once("dbconnect.php");

$name = $_POST['username'];

$email = $_POST['email'];

$password = $_POST['password'];

$passha1 = sha1($password);

$otp = rand(1000,9999);

$sqlregister = "INSERT INTO tbl_user(user_name,user_email,password,otp) VALUES('$name','$email','$passha1','$otp')";
if ($conn->query($sqlregister) === TRUE){
    echo "success";
    sendEmail($otp,$email);
   
}else{
    echo "failed";
}

function sendEmail($otp,$email){
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
    $subject = "From Home Pastry. Please Verify your account";
    $message = "<p>Click the following link to verify your account<br><br><a href='https://lowtancqx.com/s270910/homepastry/php/verity_account.php?email=".$email."&key=".$otp."'>Click Here</a>";
    
    $mail->setFrom($from,"Home Pastry");
    $mail->addAddress($to);                                             //Add a recipient
    
    //Content
    $mail->isHTML(true);                                                //Set email format to HTML
    $mail->Subject = $subject;
    $mail->Body    = $message;
    $mail->send();

}
?>