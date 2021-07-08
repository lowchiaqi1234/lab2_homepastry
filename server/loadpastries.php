<?php

include_once("dbconnect.php");

$sqlloadproduct = "SELECT * FROM tbl_products WHERE prtype='Pastries' ORDER BY prid DESC";
$result = $conn->query($sqlloadproduct);

if ($result->num_rows > 0)
{
    $response["products"] = array();
    while ($row = $result->fetch_assoc())
    {
        $productlist = array();
        $productlist['prid'] = $row["prid"];
        $productlist['prname'] = $row["prname"];
        $productlist['prtype'] = $row["prtype"];
        $productlist['prprice'] = $row["prprice"];
        $productlist['prqty'] = $row["prqty"];
        array_push($response["products"], $productlist);
    }
    echo json_encode($response);
}
else
{
    echo "nodata";
}
?>
