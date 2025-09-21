# Frequency Systems & Transmission Line Theory Projects

This repository contains the implementation of two projects in **Frequency Systems and Transmission Line Theory**, focusing on transmission line analysis, impedance matching, waveguide dielectric measurements, and antenna array design.  
The work was developed as part of the *Frequency Systems and Transmission Line Theory* course at the **Department of Electrical and Computer Engineering, Aristotle University of Thessaloniki (AUTH).**

---

## 📘 Project 1 – Transmission Line Circuits & Matching

### Topics Covered
1. **Smith Chart Analysis** – Reflection coefficient, SWR, and impedance transformations.  
2. **Frequency Domain Analysis** – Transmission-line circuits and filter design.  
3. **Conjugate Matching** – Maximum power transfer using lumped capacitors and line sections.  
4. **Multi-Stub Matching** – Optimization with evolutionary algorithms (e.g., JAYA).  

### Results & Observations
- At **f = 1 GHz**, reflection coefficient |Γ| ≈ 0.41 and SWR ≈ 2.4.  
- At **f = 4f0/3**, reflection coefficient reduced to |Γ| ≈ 0.37 and SWR ≈ 2.18.  
- Frequency response analysis verified resonance at expected frequencies.  
- Both implemented filters acted as **band-pass filters**, with sharp rejection outside the passband.  
- Conjugate matching achieved **P = 0.005 W** delivered power.  
- **Best bandwidth performance** was obtained with the capacitor connected in parallel at the load.  
- Multi-stub optimization (via JAYA) produced good broadband matching, with optimized parameters significantly reducing average |Γ| over wide frequency spans.

### Conclusions
- Smith Chart remains an essential tool for visualizing and solving transmission line problems.  
- Matching techniques strongly affect the **operating bandwidth** of a system.  
- Evolutionary optimization methods (e.g., JAYA, genetic algorithms) provide efficient solutions to otherwise complex broadband matching problems.  
- Transmission line-based filters demonstrate practical implementations of band-pass behavior in microwave circuits.  

---

## 📘 Project 2 – Waveguides & Antenna Arrays

### Topics Covered
1. **Dielectric Measurement in Waveguides** – Extracting εr and tanδ from impedance measurements.  
2. **Array Factor of Linear Antennas** – Horizontal & vertical radiation patterns.  
3. **3D Radiation Patterns** – Visualization for different inter-element spacings.  
4. **Directivity Calculations** – Numerical integration vs. theoretical expressions.  

### Results & Observations
- Using **two sample thicknesses (d and 2d)** simplified the extraction of dielectric properties, providing more accurate estimates of **εr** and **loss tangent tanδ**.  
- With only a single measurement, solving the transcendental equation was possible but more computationally challenging and prone to multiple solutions.  
- For antenna arrays with **N = 8 elements**:  
  - At **d = λ/4**, the beamwidth was wide with moderate directivity.  
  - At **d = λ/2**, a narrower beam with improved directivity was achieved.  
  - At **d = 3λ/4**, grating lobes appeared, degrading radiation performance.  
- Numerical directivity values agreed closely with the theoretical formula **D ≈ 2Nd/λ** for broadside arrays.  

### Conclusions
- Double-thickness waveguide measurements allow for **robust dielectric characterization**.  
- Antenna spacing critically impacts performance:  
  - **λ/2 spacing** provides the best trade-off between main-lobe narrowing and avoiding grating lobes.  
- Computational methods validated theoretical predictions for both dielectric properties and antenna directivity.  

---

## 🔧 Tools & Methods
- **MATLAB** and **Python** for numerical analysis, simulation, and optimization.  
- **Smith Chart techniques** for impedance and matching calculations.  
- **Optimization algorithms** (JAYA, genetic algorithms) for broadband stub design.  

---

