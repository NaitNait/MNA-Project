function vol(n1,n2,val)
% Adds the stamp of an independent voltage source with a value
% of "val" (Volts) connected between nodes n1 and n2 to the 
% matrices in the circuit representation.
%
%                   val 
%                  /  \
%      n1 O-------(+  -)--------O n2    where Vsrc= val (volts)
%                  \  /
%             Isrc ---->
%---------------------------------------------------------------

global G C b   %define global variables

d = size(C,1); % current size of the MNA
xr = d+1;      % new (extera)row/column

% Using an index bigger than the current size,  Matlab
... automatically increases the size of the matrix:
b(xr,1) = val;      % add new row

G(xr,xr) = 0;   % add new row/column
C(xr,xr) = 0;   % add new row/column

  
if (n1 ~= 0)
    G(xr,n1) = G(xr,n1) + 1;
    G(n1,xr) = G(n1,xr) + 1;
end

if (n2 ~= 0)
    G(xr,n2) = G(xr,n2) - 1;
    G(n2,xr) = G(n2,xr) - 1;
end

end %func
