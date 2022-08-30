import ddf.minim.*;
import com.hamoid.*;

Minim minim;
AudioPlayer player;
VideoExport videoExport;

float x = 0;
float y = 0;
float Cx = 0;
float Cy = 0;
boolean rotate = false;
int lenght = 0;
String FILE_NAME = "Chelidon Frame - A Circle Has No End.mp3";
// String FILE_NAME = "Chelidon Frame - Like Waves on A Pensive Evening.mp3";

float angle; 

public void settings() {
  size(960, 1080);
}


void setup() {
  
    frameRate(30);
    
    Cx = width / 2;
    Cy = height / 2;
    
    minim = new Minim(this);
    player = minim.loadFile(FILE_NAME);
    player.play();
    
    videoExport = new VideoExport(this, FILE_NAME.replace("mp3", "mp4"));
    videoExport.setFrameRate(30);
    videoExport.startMovie();
    lenght = player.length();
    
    background(0);
    
}

void draw() {
    if(rotate) {
      translate(width / 2, height / 2);
      angle = angle + PI/100;      
      rotate(angle);
    }
    videoExport.saveFrame();
    
    // background(0);
    
    stroke(map(millis(), 0, lenght, 255, 0));
    strokeWeight(1);
    noFill();
    
    drawDynamicCircle(player);
    
    x = 0;
    y = 0;
   
}

float mapToSize(float value) {
    return map(value, -1, 1, -height / 2, height / 2);
}

float mapToDynamicSize(float value) {
    // println(map(player.position(), 0, lenght, 0.1, 1));
    return map(value, -1, 1, -height, height) * map(player.position(), 0, lenght, 0.1, 1);
}

void stop() {
    videoExport.endMovie();
    exit();
}

void drawCircle(AudioPlayer player) {
    x = 0;
    y = 0;
    
    for (int i = 0; i < player.bufferSize() - 1; i++) {
        x = max(player.right.get(i), x);
        y = max(player.left.get(i), y);        
    }
    
    circle(Cx, Cy, mapToSize(x + y));        
}

void drawDynamicCircle(AudioPlayer player) {
    x = 0;
    y = 0;
    
    for (int i = 0; i < player.bufferSize() - 1; i++) {
        x = max(player.right.get(i), x);
        y = max(player.left.get(i), y);        
    }
    
    circle(Cx, Cy, mapToDynamicSize(x + y));        
}


void drawCircles(AudioPlayer player) {
    beginShape();
    for (int i = 0; i < player.bufferSize() - 1; i++) {
        
        x = player.right.get(i);
        y = player.left.get(i);
        
        circle(Cx, Cy, mapToSize(x + y));        
        
    }
    endShape();
    
}

void drawSquare(AudioPlayer player) {
  rectMode(CENTER);
  
  // noFill();
    for (int i = 0; i < player.bufferSize() - 1; i++) {
        
        x = player.right.get(i);
        y = player.left.get(i);
        
        // curveVertex(round(Cx + mapToSize(x)), round(Cy + mapToSize(y)));
        
        rect(0, 0, mapToSize(x + y), mapToSize(x + y));
    }
    
}

void drawCurve(AudioPlayer player) {
    beginShape();
    for (int i = 0; i < player.bufferSize() - 1; i++) {
        
        x = player.right.get(i);
        y = player.left.get(i);
        
        curveVertex(round(Cx + mapToSize(x)), round(Cy + mapToSize(y)));
    }
    endShape();
}
