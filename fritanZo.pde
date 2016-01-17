//Check Killyyyxxxx

import java.awt.MouseInfo;
import java.awt.Point;
import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus

String[] notas= {"C","C#/Db" ,"D", "D#/Eb", "E", "F","F#/Gb", "G", "G*/Ab", "A","A#/Bb", "B"};
String[] intervals={"3243","33333","2121222","2212221","2221"};//TO DO
int[] scale= new int[12];
int scaleLength;

//SoundMode .... midi, synth(to implement) or sample(to implement)
String[] soundModes={"midi","synth","sample"};
String soundMode = soundModes[0];

float noteSpan = 16;
int noteOn;
float keySize;
int keyHeight;
color[] texColors = {color(255, 255, 255), color(255, 0, 0)};
color texColor;

//Drones
boolean[] drones = {false, false, false, false, false, false, false};
//Drones++
Drone[] dros;
//Instrument....state already implemented
Instrument[] insts;
int dheight = width/4;


//SETUP
void setup() {
  size (500, 300);
  //size (900, 450);
  //size(1200, 1000);
  keySize= width/noteSpan;
  keyHeight = height/2;

  //MIDI
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  myBus = new MidiBus(this, 0, 1); // Create a new MidiBus using the device index to select the Midi input and output devices respectively.
  

  
  
  //Scale define
  
  int scaleInc = 60 ;
  scale[0]= scaleInc;
  scaleLength= 0;
  for (int i = 0; i<intervals[0].length(); i++){
    if (intervals[0].charAt(i) == '1'){
  scale[i+1]= scaleInc + 1;
  scaleInc = scaleInc +1;
  scaleLength++;
  }
  if (intervals[0].charAt(i) == '2'){
    scale[i+1]= scaleInc + 2;
    scaleInc = scaleInc +2;
  println(intervals[0].charAt(0));
  scaleLength++;
  }
  if (intervals[0].charAt(i) == '3'){
    scale[i+1]= scaleInc + 2;
    scaleInc = scaleInc +2;
    scaleLength++;
  }
  if (intervals[0].charAt(i) == '4'){
    scale[i+1]= scaleInc + 2;
    scaleInc = scaleInc +2;
    scaleLength++;
  }
  }
  printArray(scale);
  println(scaleLength);
  
    //Drones+++
     int droneInc =48;
  dros = new Drone[scaleLength];
  for (int i = 0; i<dros.length; i++) {
    char node = intervals[0].charAt(i%intervals[0].length());
    int  nodeInt= int (node-48);
    dros[i]= new Drone(droneInc, i);
    droneInc = droneInc+ nodeInt;
    println("Drone "+dros[i].pitch);

  }
  
  //TEST
  //Instrument++
    insts = new Instrument[int (noteSpan)];
    
    int noteInc =60; 
  for (int i = 0; i<noteSpan; i++) {
    char node = intervals[0].charAt(i%intervals[0].length());
    int  nodeInt= int (node-48);
    //println(noteInc);
    //println(nodeInt +"  " +(noteInc) +" "+   parseInt (intervals[0].charAt(i%intervals[0].length())) );
    insts[i]= new Instrument(noteInc , i, false);

    noteInc=noteInc+nodeInt;
    //insts[i]= new Instrument(noteInc+intervals[0].charAt(i%intervals[0].length()) , i, false);
    //noteInc = noteInc+intervals[0].charAt(i%intervals[0].length());
    println(insts[i].pitch);
  }
  println("**"+ insts.length);
}

//DRAW
void draw() {
  background(255, 255, 0);
  drones();
  mouse();
  instrument();
  //println(mouseY);
  //get Global Mouse!!!!!
  Point mouse;
  mouse = MouseInfo.getPointerInfo().getLocation();
  //println( "X=" + mouse.x + " Y=" + mouse.y );
}

void drones() {
  //DRONES
  for (int i = 0; i < scaleLength; i++) {

    if (mouseX > (width/scaleLength)*i && mouseX < (width/scaleLength)*i+(width/scaleLength) && mouseY > 0 && mouseY < height/2) {
      //println(keyHeight);
      //mouse(i);
      noteOn=255;


      fill(100, 100, 100);
      texColor=color(255, 255, 255);
    } else {
      noteOn= 0;
      fill(255, 255, 255);
      texColor= color(0, 0, 0);
    }
    noStroke();
    //println("hop"+i);
    if (drones[i]== true) {
      fill(100, 100, 100);
      texColor=color(255, 255, 255);
    }
    rect((width/scaleLength)*i, 0, (width/scaleLength)*(i+1), height/2);
    stroke(100, 100, 100);
    strokeWeight(width*0.001);
    line((width/scaleLength)*i, 0, (width/scaleLength)*(i), height/2);
    fill(texColor);
    textSize((width/scaleLength)/3);
    textAlign(CENTER, CENTER);
    //text(i+1, (width/drones.length)*i+(width/drones.length/2), 30);
    text(notas[dros[i].pitch%notas.length], (width/scaleLength)*i+((width/scaleLength)/2), 30);
  }
}
void instrument(){
  //KEYS
  int notaBase = 60;
  for (int i= 0; i<noteSpan; i++) {
    noStroke();
    if (mouseX > (keySize)*i && mouseX < (keySize)*i+(keySize) && mouseY > keyHeight && mouseY > height/2 && mouseY < height) {
      //println(keyHeight);
      noteOn=255;
      fill(255, noteOn, noteOn, 100+i*10 + noteOn);
      texColor=color(texColors[1]);
    } else {
      noteOn= 0;
      fill(255, noteOn, noteOn, 100+i*10 + noteOn);
      texColor= color(texColors[0]);
    }

    rect((keySize)*i, height/2, keySize, height);
    stroke(255, 255, 0);
    strokeWeight(width*0.001);
    line((keySize)*i, height/2, (keySize)*i, height);
    fill(texColor);
    textSize(keySize/3);
    textAlign(CENTER, CENTER);
     //for (int j = 0; j<noteSpan; j++) {
     //println( notas[i%notas.length]+"  "+ (notaBase+ (int (intervals[0].charAt(i%intervals[0].length()))-48)));
         //int  nodeInt= int (node-48);
         //notaBase= notaBase+ (int (intervals[0].charAt(i%intervals[0].length()))-48);
         //println(insts[i].pitch%notas.length);
         text(notas[insts[i].pitch%notas.length], (keySize)*i+(keySize/2), height/2+30);
                  //text(notas[insts[i].pitch%scaleLength], (keySize)*i+(keySize/2), height/2+90);

    //text(notas[i%notas.length], (keySize)*i+(keySize/2), height/2+30);
    
     //}
  }
}

//MOUSE
void mouse() {
  //if (mousePressed == true) {
  //for (int j=0; j< drones.length; j++) {
  // drones[j]=false;
  // }
  //drones[i]= true;

  //}
  
  //Instrument  
  for (int i = 0; i<noteSpan; i++) {
    //Note ON
    if (mouseX > (keySize)*i && mouseX < (keySize)*i+(keySize) && mouseY > keyHeight && mouseY > height/2 && mouseY < height) {
    insts[i].update();
    
    }
    
    if (mouseX <= (keySize)*i || mouseX > (keySize)*i + (keySize)  ) {
      if (insts[i].state == true){
       //insts[i].state = false;
       insts[i].update();
      }
     //print (insts[i]+" ");
    if (mouseY <=  keyHeight){
          if (insts[i].state == true){
       //insts[i].state = false;
       insts[i].update();
      }
    } 
    }
        if(mouseY <= keyHeight && insts[i].state==true){
            insts[i].state=false;
            insts[i].kill();

     }
    //print (insts[i].state+" ");
    
  }
  //printArray(insts);
}


void mouseReleased() {
  //for (int i = 0; i<drones.length; i++) {
  //  drones[i] = false;
  //  println("index"+i+" "+qdrones[i]);
  //}
  println("next");
  
  //Drones with Mouse
  for (int i = 0; i<drones.length; i++) {

    if (mouseX >= (width/scaleLength)*i && mouseX < (width/scaleLength)*i+(width/scaleLength) && mouseY > 0 && mouseY < height/2) {
      if (drones[i] == true) {
        for (int j = 0;j<scaleLength;j++){
        if(j != i){drones[j]= false;}
        }
        drones[i]= false;
        println("***erase "+i);
        dros[i].update();

      } else
      if (drones[i]== false) {

        for (int j = 0;j<scaleLength;j++){
        if (drones[j]== true){
          drones[j]= false;
          dros[j].update();
          println("***erase "+j);
        }
        }
        drones[i]= true;
        dros[i].update();
        println("***note on "+i);
      }
    }    
  }
}



//
//KEYS
void keyPressed() {
  if (keyPressed == true) {
    //println(keyCode);
  

  switch(key) {
  case '1':
    //file[0].play(0.5, 1.0);
    insts[1].update();
    println(insts[1].state);
    break;

  case '2':
    //file[1].play(0.5, 1.0);
    break;

  case '3':
    //file[2].play(0.5, 1.0);
    break;

  case '4':
    //file[3].play(0.5, 1.0);
    break;

  case '5':
    //file[4].play(0.5, 1.0);
    break;

  case '6':
    //file[0].play(1.0, 1.0);
    break;

  case '7':
    //file[1].play(1.0, 1.0);
    break;

  case '8':
    //file[2].play(1.0, 1.0);
    break;

  case '9':
    //file[3].play(1.0, 1.0);
    break;

  case '0':
    //file[4].play(1.0, 1.0);
    break;
  case 'q':
    //file[4].play(1.0, 1.0);
quitSound();
    break;
  }
 }
}

//KILL SOUND!!!!!!!!!
void quitSound(){
    for (int i = 0; i<drones.length; i++) {
      drones[i] = false;
      //println("index"+i+" "+drones[i]);
    }
      for (Drone dro : dros) {
  dro.update();
  }
  
  //
  for(int i = 0; i<insts.length; i++){
    print("bUM");
   insts[i].state = false;
    //insts[i].update();
   insts[i].kill();
  }
    //ControlChange change = new ControlChange(1, 123, 0);
  //myBus.sendControllerChange(change); // Send a controllerChange
  print("bang");
  //for(int i = 0; i<129; i++){
  //Note note = new Note(1, i, 0);
  //myBus.sendNoteOff(note);
}
//}