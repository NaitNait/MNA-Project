function vcvs_Inf(nd1,nd2,ni1,ni2)
% Adds the stamp of a dependent voltage-controlled 
% voltage-source (VCVS) to the matrices in the circuit 
% representation.
%
%   ni1 O-------(+)        |----------o nd1
%                          |
%                         /+\
%                      | /   \    Vnd1-Vnd2 = val*(Vni1-Vni2)
%                Ivcvs | \   /
%                      V  \-/ 
%                          |
%   ni2 O-------(-)        |----------o nd2
%
%  (1) "nd1 & nd2" are the nodes across the dependent
%                  voltage source.
%  (2) "ni1 & ni2" are the nodes corresponding to the 
%                  controller voltage
%
%   nd1: (+) node   \
%   nd2: (-) node   |----->  Vnd1-Vnd2 = val*(Vni1-Vni2)
%   ni1: (+) node   |
%   ni2: (-) node   /
%---------------------------------------------------------------

global G C b   %define global variables

d = size(C,1); % current size of the MNA
xr = d+1;      % new (extera)row/column

% Using an index bigger than the current size,  Matlab
... automatically increases the size of the matrix:

b(xr,1) = 0;      % add new row
G(xr,xr) = 0;   % add new row/column
C(xr,xr) = 0;   % add new row/column

if (ni1 ~= 0)
    G(xr,ni1) = G(xr,ni1) - 1;
end

if (ni2 ~= 0)
    G(xr,ni2) = G(xr,ni2) + 1;
end

if (nd1 ~= 0)
    G(nd1,xr) = G(nd1,xr) + 1;
end

if (nd2 ~= 0)
    G(nd2,xr) = G(nd2,xr) - 1;
end

end %func

