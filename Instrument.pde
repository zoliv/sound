class Instrument{
  int channel = 0;
  int pitch;
  int velocity = 127; // maybe get mouseY
  int index;
  boolean state;
  
  Instrument(int _pitch, int _index, boolean _state){
     pitch= _pitch;
     index= _index;
     state = _state;
     
  }
      //Note note = new Note(channel, pitch, velocity);
  void update(){
    Note note = new Note(channel, pitch, velocity);
     if(state== true && mouseX > (keySize)*index && mouseX < (keySize)*index+(keySize) && mouseY > keyHeight && mouseY > height/2 && mouseY < height && mouseX != pmouseX && mouseY != pmouseY){
     //myBus.sendNoteOff(note); // Send a Midi nodeOff
      //println(str(pitch)+" OFF "+ index +" instrument=" + state);
     // println("index:"+index+" "+str(pitch)+" do nothing / state="+state);
     }else
     if(state== true && mouseX <= (keySize)*index || mouseX > (keySize)*index + (keySize) ){
         state= false;
       myBus.sendNoteOff(note); // Send a Midi nodeOff
       
      //println("index:"+index+" "+str(pitch)+" OFF "+ index +" instrument=" + state);
     }else
     
     if(state== false ){
      state= true;
     myBus.sendNoteOn(note); // Send a Midi noteOn
     //println(str(pitch)+" ON "+ index +" instrument=" + state);
     
    }

    
    if (keyPressed == true && key== 'Q' || key == 'q'){
      //state= false;
    //myBus.sendNoteOff(note); // Send a Midi nodeOff
    //print("bam");
    //state= false;
    
  //ControlChange change = new ControlChange(1, 123, 0);

  //myBus.sendControllerChange(change); // Send a controllerChange    
    }
     
  }
  void kill(){
         Note note = new Note(channel, pitch, velocity);
         myBus.sendNoteOff(note); // Send a Midi nodeOff
         println("kiled"+pitch);

  }
  
}