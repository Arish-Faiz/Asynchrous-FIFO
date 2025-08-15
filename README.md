# 🌀 Asynchronous FIFO Design

![Verilog](https://img.shields.io/badge/HDL-Verilog-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

## 📜 Overview
This repository contains the **design and implementation of an Asynchronous FIFO** in Verilog HDL, based on proven methodologies for reliable **Clock Domain Crossing (CDC)**.

The design uses **Gray code pointers** to ensure safe synchronization between asynchronous write and read clock domains, along with robust `full` and `empty` detection logic.

---

## 🚀 Features
- **Dual-clock asynchronous FIFO**
- **Gray code pointer synchronization**
- **Full and Empty flag logic**
- Modular, synthesis-friendly architecture
- Includes complete **Verilog RTL source code**

---

## 📂 Project Structure

---

## 🛠️ Design Modules
| Module        | Description |
|---------------|-------------|
| `fifol.v`     | Top-level FIFO module |
| `fifomem.v`   | Dual-port memory buffer |
| `sync_r2w.v`  | Read-to-Write clock domain synchronizer |
| `sync_w2r.v`  | Write-to-Read clock domain synchronizer |
| `rptr_empty.v`| Read pointer + empty flag logic |
| `wptr_full.v` | Write pointer + full flag logic |
