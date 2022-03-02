public class SOS {
  ArrayList<PCB> processTable;
  ArrayList<Partition> partitionTable;
  int partitions;
  int partitionSize;
  PCB active;

  SOS(int p) {
    partitions = p;
    processTable = new ArrayList<PCB>();
    partitionTable = new ArrayList<Partition>();
    partitionSize = myPC.RAM.length/partitions;
  }

  void startOS() {
    for (int i=0; i<partitions; i++) {
      partitionTable.add(new Partition(partitionSize, i*partitionSize));
    }
    active = null;
    myPC.counter=0;
  }

  void loadProgram(String p) {
    String processImage = myPC.HDD.get(p)+"hhhhhhssssss";

    //Search the partition table for a partition  
    for (Partition partition : partitionTable) {
      if (partition.isFree && partition.size>=processImage.length()) {
        //First update the process table
        PCB processDescriptor = new PCB(partition.baseAddress);
        processTable.add(processDescriptor);
        //Then copy the process to the RAM
        for (int i=0; i<processImage.length(); i++) {
          myPC.RAM[i+partition.baseAddress] = processImage.charAt(i);
        }
        //this partition is no longer available
        partition.isFree = false;
        break;
      }
    }
    if(active==null){
      schedule();
    }
  }

  void schedule() {
    if (processTable.isEmpty()) {
      myPC.counter=0;
      active = null;
    } else {
      active = processTable.get(0);
      active.isRunning=true;
      myPC.counter=active.baseAddress;
    }
  }

  void cleanup() {
    //1 find the partition
    for (Partition partition : partitionTable) {
      if (partition.baseAddress == active.baseAddress) {
        //2 empty the partition
        for (int i=0; i<partition.size; i++) {
          myPC.RAM[i+partition.baseAddress] = ' ';
        }
        partition.isFree=true;
        //3. Remove from the process table
        processTable.remove(active);
        break;
      }
    }
  }
}
