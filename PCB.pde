class PCB{
  //int PID; //Who am I?
  boolean isRunning; //What is my state?
  int baseAddress; //Where am I?
  int programCounter; //How far have I progressed?
  
  PCB(int ba){
    isRunning = false;
    baseAddress = ba;
    programCounter = 0;
  }
}
