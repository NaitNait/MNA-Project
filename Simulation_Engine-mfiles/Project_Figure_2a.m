% ELEC 4907
% Authors: Justin Leakey, Natalia Fomenko, TianTian Dai, Adam Gas 
% Date: November 27, 2021 
% Circuit in Figure 2a
%--------------------------------------------------------------------------

clc; close all;  clear all;  %initialization of the matlab environment

global G C b; %define global variables

NrNodes = 8;  % The total number of nodes in the circuit

% Define G, C, b, for a circuit (do not include additional variables).
G = sparse(NrNodes,NrNodes); 
C = sparse(NrNodes,NrNodes);
b = sparse(NrNodes,1);

%--------------------------------------------------------------------------
% Original network values
%--------------------------------------------------------------------------
G_1 = 1;
G_2 = 1;
G_3 = 1;
G_4 = 1;
G_5 = 1;

C_1 = 3;
C_2 = 0.3;
C_3 = 6;
C_4= 0.1;
C_5 = 10;

%--------------------------------------------------------------------------
% Netlist
%--------------------------------------------------------------------------
% horizontal components
res(1,2,1/G_1);
res(2,3,1/G_2);
res(3,4,1/G_3);
cap(3,5,C_3);
res(5,6,1/G_4);
res(6,8,1/G_5);
cap(6,7,C_5);

vcvs_Inf(5,0,4,5);
vcvs_Inf(7,0,8,7)

% vertical components
cap(2,0,C_1);
cap(4,0,C_2);
cap(8,0,C_4);

vol(1,0,1);
%-------------------------------------------------------------------------- 
% Plot Vout (in Volts) versus frequency (in Hz) 
%-------------------------------------------------------------------------- 
OutputNode = 7;

fmin = 0;     %Hz
fmax = 1.2/(2*pi);  %Hz
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

F = linspace(fmin, fmax, Nrpt);
w = 2*pi*F;

figure('Name','Filter Response');  %Optional
plot(w, mag2db(abs(Vout)),'LineWidth',3);
grid;
title('Filter Response', 'FontSize',16);
xlabel('Angular Frequency  (rad/s)','FontSize',16);
ylabel('|V_{out}/V_{in}|  (dB)','FontSize',16);
legend('Node#7','FontSize',16)
axis([0,1.2,-2,3])



