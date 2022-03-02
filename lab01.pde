final color green=color(0, 255, 0);
final color red=color(255, 0, 0);
final color pink=color(245, 153, 243);

Hardware myPC;
int simSpeed;


void setup() {
  size(850, 350);
  //surface.setLocation(4500-width, 40);
  myPC=new Hardware(50);
  myPC.boot();
  frameRate(30);
  simSpeed = 20;
}

void draw() {
  background(128);
  drawRAM();
  if (frameCount % simSpeed ==0) {
    myPC.clock++;
    myPC.fetch();
    char c = myPC.execute();
    if (c=='*') {
      println("At time "+myPC.clock+" excuted "+c);
    } else if (c=='$') {
      println("At time "+myPC.clock+" excuted "+c);
    } else if (c==' ') {
      println("waiting for user input");
    }
  }
}

void drawRAM() {
  int rects = myPC.RAM.length;
  float rectSize = width / rects;
  stroke(0);

  textAlign(CENTER, CENTER);
  for (int i=0; i<rects; i++) {
    if ( myPC.RAM[i]=='0') fill(255);
    else{ 
      if(myPC.counter == i) fill(red);
      else if(i <= myPC.counter) fill(pink);
      else fill(green);
    }
    rect(i*rectSize, 0, rectSize, rectSize);
    fill(0);
    text(myPC.RAM[i], i*rectSize+rectSize/2, rectSize/2);
  }
}

void loadProgram(String p) {
  myPC.RAMinit();
  String process = myPC.HDD.get(p)+"hhhhhhssssss";
  for (int i=0; i<process.length(); i++) {
    myPC.RAM[i] = process.charAt(i);
  }
  myPC.counter=0;
}

void keyPressed() {
  if (key == '1') {
    loadProgram("program1.exe");
  } else if (key == '2') {
    loadProgram("program2.exe");
  } else if (key == '3') {
    loadProgram("program3.exe");
  }else if(key == CODED){
    if(keyCode == LEFT) {
      simSpeed +=5;  
    }else if(keyCode == RIGHT) {
      simSpeed -=5;
    }
    simSpeed = constrain(simSpeed, 1, 30); 
  }
}
