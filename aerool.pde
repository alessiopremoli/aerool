import ddf.minim.*;
import com.hamoid.*;

Minim minim;
AudioPlayer player;
VideoExport videoExport;

float x = 0;
float y = 0;
float Cx = 0;
float Cy = 0;
String FILE_NAME = "Chelidon Frame - Mist of Numbers, Fog of Worlds.mp3";

void setup() {
  
  size(1000,1000);
  
  Cx= 500;
  Cy= 500;
  
  minim = new Minim(this);
  player = minim.loadFile(FILE_NAME);
  player.play();
  
  videoExport = new VideoExport(this, "output.mp4");
  videoExport.setFrameRate(30);
  videoExport.startMovie();
  
  background(0);
  
}

void draw() {
  videoExport.saveFrame();
   //fill(0);
   //background(0);
   
   stroke(map(millis(), 0, 444000, 255, 0));
   strokeWeight(1);
   noFill();
   
   beginShape();
   for(int i = 0; i <player.bufferSize() - 1; i++) 
   {
     
     x = sin(player.right.get(i));
     //x=player.left.get(i);
     y = sin(player.left.get(i));
     //x = player.right.get(i);
     
    curveVertex(round(Cx+mapToSize(x)), round(Cy+mapToSize(y)));
    //vertex(Cx+player.right.get(i+1)*500, Cy-player.left.get(i+1)*500);
     
   }
   endShape();
   
   x = 0;
   y = 0;
}

float mapToSize(float value) {
  return map(value, -1, 1, -height/2, height / 2);
 
}

void stop() {
  videoExport.endMovie();
  exit();
}
