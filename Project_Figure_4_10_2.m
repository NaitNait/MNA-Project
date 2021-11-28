% ELEC 4907
% Authors: Justin Leakey, Natalia Fomenko, TianTian Dai, Adam Gas 
% Date: November 27, 2021 
% Circuit in Figure 4.10.2
%--------------------------------------------------------------------------
clc; close all;  clear all;  %initialization of the matlab environment

global G C b; %define global variables

NrNodes = 26;  % The total number of nodes in the circuit

% Define G, C, b, for a circuit (do not include additional variables).
G = sparse(NrNodes,NrNodes); 
C = sparse(NrNodes,NrNodes);
b = sparse(NrNodes,1);

%--------------------------------------------------------------------------
% 1. Original network values
%--------------------------------------------------------------------------
R_1 = 5.4779e3;
R_2 = 2.0076e3;
R_5 = 4.5898e3;
R_6 = 4.44e3;
R_7 = 5.9999e3;
R_10 = 4.25725e3;
R_11 = 3.2201e3;
R_12 = 5.88327e3;
R_15 = 5.62599e3;
R_16 = 3.63678e3;
R_17 = 1.0301e3;
R_20 = 5.808498e3;
R_21 = 1.2201e3;

C_1 = 12e-9;
C_2 = 10e-9;
C_3 = 6.8e-9;
C_4 = 10e-9;
C_5 = 4.7e-9;
C_6 = 10e-9;
C_7 = 6.8e-9;
C_8 = 10e-9;
C_9 = 10e-9;

R_3 = 3.3e3; % in branch 1
R_4 = 3.3e3;

R_8 = 3.3e3; % in branch 2
R_9 = 3.3e3;

R_13 = 3.3e3; % in branch 3
R_14 = 3.3e3;

R_18 = 3.3e3; % in branch 4
R_19 = 3.3e3;

%--------------------------------------------------------------------------
% Netlist
%--------------------------------------------------------------------------
% horizontal branch
res(26,1,R_1);
res(1,2,R_6);
res(2,3,R_11);
res(3,4,R_16);
res(4,5,R_21);
cap(5,0,C_9);

% vertical branch 1 (left to right)
res(1,6,R_2);
cap(6,10,C_1);
res(10,14,R_3);
res(14,18, R_4);
res(18,22,R_5);
cap(22,0,C_2);
vcvs_Inf(10,0,22,14);
vcvs_Inf(18,0,6,14);

% vertical branch 2 
res(2,7,R_7);
cap(7,11,C_3);
res(11,15,R_8);
res(15,19,R_9);
res(19,23,R_10);
cap(23,0,C_4);
vcvs_Inf(11,0,23,15);
vcvs_Inf(19,0,7,15)

% vertical branch 3
res(3,8,R_12);
cap(8,12,C_5);
res(12,16,R_13);
res(16,20,R_14);
res(20,24,R_15);
cap(24,0,C_6);
vcvs_Inf(12,0,24,16);
vcvs_Inf(20,0,8,16);

% vertical branch 4
res(4,9,R_17);
cap(9,13,C_7);
res(13,17,R_18);
res(17,21,R_19);
res(21,25,R_20);
cap(25,0,C_8)
vcvs_Inf(13,0,25,17);
vcvs_Inf(21,0,9,17);

vol(26,0,1);
%-------------------------------------------------------------------------- 
% Question 3. Step 2. Plot Vout (in Volts) versus frequency (in Hz) 
%-------------------------------------------------------------------------- 
OutputNode = 5;

fmin = 400;     %Hz
fmax = 50e3;  %Hz
Nrpt = 1000;  %Number of frequency points

F = linspace(fmin, fmax, Nrpt);

Vout = zeros(Nrpt,1);

for n=1:Nrpt
    w = 2*pi*F(n);
    s = 1i*w;
    A = G + s*C; 

    [L,U,P,Q] = lu(A, 0.1);
    z = L\(P*b);
    y = U\z;
    X = Q*y; 
    
    Vout(n,1) = X(OutputNode);  % The voltage at output node "X(OutputNode)"
                              ... is collected in an array "Vout(n)"
                              ... for every frequency.
end
figure(1)
plot(F, mag2db(abs(Vout)),'LineWidth',3);
grid;
title('Filter Response', 'FontSize',16);
xlabel('Frequency  (Hz)','FontSize',16);
ylabel('|V_{out}|  (dB)','FontSize',16);
legend('Node#5','FontSize',16)
axis([400,4000,-0.05,0.01])

figure(2)
semilogx(F, mag2db(abs(Vout)),'LineWidth',3);
grid;
title('Filter Response', 'FontSize',16);
xlabel('Frequency  (Hz)','FontSize',16);
ylabel('|V_{out}|  (dB)','FontSize',16);
legend('Node#5','FontSize',16)
axis([0.5e3,50e3,-80,20])



