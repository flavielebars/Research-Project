# Research-Project
Arduino &amp; MATLAB codes I wrote for my Research Project at the University of Bristol - Redesigning the communication system of a meteorological space station measuring cosmic rays in Snowdonia (71%).

I worked on a weather station based in Snowdon. It measures cosmic rays to evaluate their link to climate change. However, the communication system was broken, and I was tasked with designing a modernised version to collect and send the data back to the University. The new system is made of a Teensy used as a data logger and LoRa radios to transmit the data. The cosmic rays are measured with a coincidence counter made of two Geiger counters, and one of them was suspected to be broken so a part of my research was to test them. I prototyped the Teensy data logger and tested it to ensure it was correctly detecting the cosmic rays. The research was a success, the new communication system will be implemented and allow the station to be running again.

The codes included in this repository:

    - Arduino code to use the Teensy 4.1 as a datalogger.
    
    - MATLAB code to show that the Teensy 4.1 is as accurate as the proprietary system previously implemented at the station.
