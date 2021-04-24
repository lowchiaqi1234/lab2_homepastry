<?php
$servename = "localhost";
$username = "lowtancq_homepastryadmin";
$password = "AQcCV8XiA8EG";
$dbname = "lowtancq_homepastry";

$conn = new mysqli($servename, $username, $password, $dbname);
if($conn->connect_error){
    die("Connection failed:" . $conn->connect_error);
}
?>