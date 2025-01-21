
---

# **Digital Clock Design on MAX 10 FPGA**

## **Project Overview**
This project implements a 24-hour digital clock on the Intel MAX 10 FPGA development board. The clock displays time in hours, minutes, and seconds using modular Verilog code. This design includes simulation using ModelSim and hardware implementation using Quartus Prime.

The project demonstrates:
- Modular design principles in Verilog.
- Real-time simulation and validation.
- FPGA hardware application workflows.

---

## **Project Features**
- **24-Hour Clock Format**: Displays time in HH:MM:SS.
- **Simulation and Verification**: Testbench files provided for functional simulation in ModelSim.
- **FPGA Deployment**: Fully implemented and synthesized for the MAX 10 FPGA using Quartus Prime.
- **Hierarchical Design**: Features a modular approach with clear separation of functionality.

---

## **Folder Structure**
- **`modelsim/`**: Contains simulation files and testbenches for verifying functionality.
- **`quartus/`**: Includes all files related to the FPGA implementation, such as the Quartus project file, pin assignments, and synthesized netlist.

---

## **Key Modules**
1. **`bin2bcd`**: Converts binary time values into BCD format for display purposes.
2. **`timer`**: Handles the counting logic for seconds, minutes, and hours.
3. **`hex_7seg_decoder`**: Decodes BCD values to control seven-segment displays.
4. **`timer_top`**: The top-level module integrating all other components.

---

## **Tools and Technologies**
- **FPGA Board**: Intel MAX 10 FPGA.
- **Languages**: Verilog for design and testbenches.
- **Software Tools**:
  - **ModelSim**: For functional simulation of the design.
  - **Intel Quartus Prime**: For FPGA synthesis and implementation.

---

## **How to Use**
### **Simulation with ModelSim**
1. Navigate to the `modelsim/` folder.
2. Open ModelSim and load the testbench files.
3. Simulate the design to verify functionality.

### **Implementation on MAX 10 FPGA**
1. Navigate to the `quartus/` folder.
2. Open the Quartus Prime project.
3. Assign FPGA pins according to your board configuration.
4. Compile the project to generate the `.sof` file.
5. Use the USB-Blaster to program the MAX 10 FPGA.

---

## **Learning Outcomes**
- Hands-on experience with FPGA development workflows.
- Proficiency in Verilog-based modular design.
- Skills in using ModelSim for simulation and Quartus Prime for hardware implementation.
- Understanding of clock division, binary-to-BCD conversion, and seven-segment decoding.

---

## **Future Enhancements**
- Add an alarm clock feature.
- Implement real-time clock (RTC) integration for enhanced accuracy.
- Design a user interface for time adjustments.

---

## **Contributor**
- **Shreel Pancholi**  
  Third-year B.Tech student in Electronics and Communication Engineering, Pandit Deendayal Energy University(PDEU)
