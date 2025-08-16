# 🌀 Asynchronous FIFO Design (Self Project)

![Verilog](https://img.shields.io/badge/HDL-Verilog-blue.svg)

## 📜 Overview
This repository contains the **design and implementation of an Asynchronous FIFO** in Verilog HDL, based on proven methodologies for reliable **Clock Domain Crossing (CDC)**.

The design uses **Gray code pointers** to ensure safe synchronization between asynchronous write and read clock domains, along with robust `full` and `empty` detection logic.

---

## 🚀 Features
- **Dual-clock asynchronous FIFO**
- **Gray code pointer synchronization**
- **Full and Empty flag logic**
- Includes complete **Verilog RTL source code**

---

## 📂 Project Structure

## 🛠️ Design Modules
| Module        | Description |
|---------------|-------------|
| `fifol.v`     | Top-level FIFO module |
| `fifomem.v`   | Dual-port memory buffer |
| `sync_r2w.v`  | Read-to-Write clock domain synchronizer |
| `sync_w2r.v`  | Write-to-Read clock domain synchronizer |
| `rptr_empty.v`| Read pointer + empty flag logic |
| `wptr_full.v` | Write pointer + full flag logic |



---

## 🧪 Testbench Verification

- **FIFO Depth**: 16  
- **Write Clock (wclk)**: 125 MHz (8 ns period)  
- **Read Clock (rclk)**: 25 MHz (40 ns period)  
- **Burst Scenario**: Write a continuous burst of 20 words  

**Observed Behavior in Simulation:**  
- FIFO successfully accepts the first **16 words**  
- The **wfull flag** asserts as expected   
- ✅ No data corruption occurs



---

## 🛠 Technologies Used
- **RTL Design:** Verilog HDL  
- **Verification:** Verilog Testbench, ModelSim/Vivado Simulator  


---
## 📖 Reference
Based on methodology from:  
> Clifford E. Cummings, *Simulation and Synthesis Techniques for Asynchronous FIFO Design*


---

## 👨‍💻 Author
**Arish Faiz**  
Branch: **EE6 (ICS)**  
Roll No: **23M1179**  
**Indian Institute of Technology Bombay (IIT Bombay)**
