public class Hardware{
  /*Instruction Set
     * = any normal instruction add, sub, load etc
     $ = System call for exiting the program (normal exit)
     d = a variable
     an example of a program: ********$ddddd
  */

  //CPU Registers
  int counter; //Program Counter holds the address of the current/next instruction being executed
  char IR; //Instruction Register holds the actual instruction being executed
  
  char[] RAM;
  
  HashMap<String, String> HDD;
  
  int clock;

  Hardware(int RAMsize){
    RAM = new char[RAMsize];
    HDD = new HashMap<String, String>();
  }
  
  void boot(){
    RAMinit();
    clock = 0;
    counter = 0;
    moundHDD();
  }
  
  void RAMinit(){
    for(int i=0; i<RAM.length; i++){
      RAM[i] = ' ';
    }
  }
  
  void moundHDD(){
    HDD.put(new String("program1.exe"), new String("*********$ddd"));
    HDD.put(new String("program2.exe"), new String("*****$ddd"));
    HDD.put(new String("program3.exe"), new String("******************$d"));
  }
  
  void fetch(){
    IR = RAM[counter];
  }
  
  char execute(){
    if(IR=='*'){
      counter++;
    }else if(IR=='$'){
      RAMinit();
      counter=0;
    }else if(IR==' '){
      //Do nothing
    }
    return IR;
  }
  
  
}
