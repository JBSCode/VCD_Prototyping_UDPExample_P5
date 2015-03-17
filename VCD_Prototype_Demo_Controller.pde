 
 // Processing UDP example to send and receive string data from Arduino 
 // press any key to send the "Hello Arduino" message
 
 
 import hypermedia.net.*;
 
 UDP udp;  // define the UDP object
 
 
 void setup() {
 udp = new UDP( this, 6000 );  // create a new datagram connection on port 6000
 //udp.log( true );     // <-- printout the connection activity
 udp.listen( true );           // and wait for incoming message  
 }
 
 void draw()
 {
 }
 
 void mouseMoved(){
   String ip       = "192.168.0.177";  // the remote IP address
   int port        = 8888;    // the destination port
   
   int pos = (int)map((int)mouseX, 0, (int)width, 0, 31);
   byte[] data = new byte[32];
   
   for(int i=0;i<32;i++){
     data[i] = (byte)map(Math.abs(pos-i),0,32,0,254);
   }
   udp.send(data, ip, port );   // the message to send
 }
 
 void receive( byte[] data ) {       // <-- default handler
 //void receive( byte[] data, String ip, int port ) {  // <-- extended handler
 
   boolean firstPart = true;
   int counter = 0;
   for(int i=0; i < data.length; i++) {
     if( firstPart ){
       print(char(data[i]));
     }else{
       counter ++;
       
       print( String.format(" %d=%02x", counter, (int) data[i]) );
     }
     
     if(char(data[i]) == ':') firstPart = false;
   }
   
   println();   
 }
