@RestResource(urlMapping='/DataAvailable')

Global class ConnectOrg {
@httppost
    global static Contact getContact(){
        Contact con = [Select Id,Name from Contact where Id ='003IR00001kF9AvYAK'];
        system.debug(con);
        return con;
    }
}