<?php

// DB credentials
$host = "localhost";
$user = "root";
$password = "Montclair";
$database = "bus_app";

// Create a connection
$db_connection = new mysqli($host, $user, $password, $database);

// Check the connection
if ($db_connection->connect_error) {
    die("Connection failed: " . $db_connection->connect_error);
}