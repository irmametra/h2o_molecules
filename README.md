# scoop_project

H2O Concurrency Problem Statement
The problem is a typical concurrency problem explained in the Little Book for Semaphores http://www.greenteapress.com/semaphores/downey08semaphores.pdf  and it defines two threads: oxygen and hydrogen. These threads should be assembled into water molecules. For this to happen one needs to use a barrier which makes each thread wait until a molecule is ready. Upon barrier passing, each thread calls bond. All the threads from one molecule must invoke bond before any of the threads from the next molecule do. 
In other words: 
• If an oxygen thread arrives at the barrier when no hydrogen threads are present, it has to wait for two hydrogen threads. 
• If a hydrogen thread arrives at the barrier when no other threads are present, it has to wait for an oxygen thread and another hydrogen thread. 

We don’t have to worry about matching the threads up explicitly; that is, the threads do not necessarily know which other threads they are paired up with. The key is just that threads pass the barrier in complete sets; thus, if we examine the sequence of threads that invoke bond and divide them into groups of three, each group should contain one oxygen and two hydrogen threads. 
In this project we present the solution in SCOOP.

