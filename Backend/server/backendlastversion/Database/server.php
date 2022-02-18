<?php

class Data_user
{

    // CHANGE THE DB INFO ACCORDING TO YOUR DATABASE
    // private $db_host = 'localhost';
    // private $db_name = 'nectecpro';
    // private $db_username = 'root';
    // private $db_password = '';
    private $db_host = 'localhost';
    private $db_name = 'nectecpro';
    private $db_username = 'root';
    private $db_password = '';

    public function dbConnect()
    {

        try {
            // $cont = new PDO('mysql:host='.$this->db_host.';dbname='.$this->db_name,$this->db_username,$this->db_password );
            $cont = new PDO("mysql:host=$this->db_host;dbname=$this->db_name;charset=utf8mb4;", $this->db_username, $this->db_password);
            // $cont->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            return $cont;
        } catch (PDOException $e) {
            echo "Connection error " . $e->getMessage();
            exit;
        }
    }
}
class Data_pic
{

    // CHANGE THE DB INFO ACCORDING TO YOUR DATABASE
    private $db_host = 'localhost';
    private $db_name = 'nectecpro';
    private $db_username = 'root';
    private $db_password = '';

    public function dbConnect()
    {

        try {
            $cont = new PDO("mysql:host=$this->db_host;dbname=$this->db_name;charset=utf8mb4;", $this->db_username, $this->db_password);
            $cont->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            return $cont;
        } catch (PDOException $e) {
            echo "Connection error " . $e->getMessage();
            exit;
        }
    }
}
