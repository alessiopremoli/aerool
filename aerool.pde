import ddf.minim.*;
import com.hamoid.*;

Minim minim;
AudioPlayer player;
VideoExport videoExport;

float x = 0;
float y = 0;
float Cx = 0;
float Cy = 0;
String FILE_NAME = "Chelidon Frame - Glorified Busy.wav";

void setup() {
  
  size(1000,1000);
  
  Cx= width / 2;
  Cy= height / 2;
  
  minim = new Minim(this);
  player = minim.loadFile(FILE_NAME);
  player.play();
  
  videoExport = new VideoExport(this, FILE_NAME.replace("wav", "mp4"));
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
     y = sin(player.left.get(i));
     
    curveVertex(round(Cx+mapToSize(x)), round(Cy+mapToSize(y)));
     
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
