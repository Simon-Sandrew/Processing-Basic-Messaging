import processing.net.*;
String senderName = "Server";
String message = "";
char lastKey;

Server s;
Client c;
String[] loggedMsgs = new String[10];

void setup() {  
  size(400,400);
  s = new Server(this, 5000);
  c = new Client(this,"localhost", 5000);
  
  
  
  frameRate(10);
  for(int i = 0; i<loggedMsgs.length; i++){
    loggedMsgs[i] = "";
  }
}

void draw() {
   background(255);
    fill(200);
  noStroke();
  rect(15,335,365,20);
  rect(15,2,365,290);
  fill(0);
  for(int i = 0; i<loggedMsgs.length; i++){
    text(loggedMsgs[i],20,(30*i) + 12);
  }
 
 
  fill(0);
  text(message,20,350);
  
  c = s.available();
  if (c != null) {
    String fromServer = c.readString();
    updateMsgs(fromServer);
  }
}

void keyPressed() {
  if(key == ENTER){
    if(!(message.trim()).isEmpty()){
      message = senderName+ ": " + message;
      updateMsgs(message);
      s.write(message);
      message = "";
    }
  }
  else if(key<127 && key>31){
    message = message + key;
  }
  if(key == BACKSPACE && message.length()>0){
    message = message.substring(0,message.length()-1);
    
  }
}

void updateMsgs(String msg){
  for(int i = 0; i<loggedMsgs.length; i++){
     
     if(i == loggedMsgs.length-1){
       loggedMsgs[i] = msg;
       continue;
     }
     loggedMsgs[i] = loggedMsgs[i+1];
  }
}