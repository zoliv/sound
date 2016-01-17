class Drone{
  int channel = 0;
  int pitch;
  int velocity = 127;
  int index;
  
  Drone(int _pitch, int _index){
     pitch= _pitch;
     index= _index;
     
  }
  void update(){
    Note note = new Note(channel, pitch, velocity);
    if(drones[index]== true){
     myBus.sendNoteOn(note); // Send a Midi noteOn
     //println(str(pitch)+" ON "+ index +" drones=" + drones[index]);
     
    }
     if(drones[index]== false){
     myBus.sendNoteOff(note); // Send a Midi nodeOff
      //println(str(pitch)+" OFF "+ index +" drones=" + drones[index]);
     }
  }
  
}