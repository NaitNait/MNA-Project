function vccs(no1, no2, ni1, ni2, val)
% Adds the stamp of a dependent voltage-controlled 
% current-source (VCCS) to the G matrix in the circuit 
% representation.
%
%   ni1 O-------(+)   |----------o no1
%                     |
%                    / \
%                   / | \  val*(Vni1 - Vni2)
%                   \ V /
%                    \ /    
%                     |
%   ni2 O-------(-)   |----------o no2
%
%  (1) "no1 & no2" are the nodes across the dependent
%                  current source.
%  (2) "ni1 & ni2" are the nodes corresponding to the 
%                  controller voltage
%
%   no1:  The node at the tail of the current arrow
%   no2:  "   "   "   "  head  "    "   "      "   
%   ni1: (+) node
%   ni2: (-) node
%---------------------------------------------------------------

global G   %define global variable

if (no1 ~= 0) && (ni1 ~= 0) 
    G(no1,ni1) = G(no1,ni1) + val;
end

if (no2 ~= 0) && (ni2 ~= 0) 
    G(no2,ni2) = G(no2,ni2) + val;
end

if (no1 ~= 0) && (ni2 ~= 0) 
    G(no1,ni2) = G(no1,ni2) - val;
end

if (no2 ~= 0) && (ni1 ~= 0) 
    G(no2,ni1) = G(no2,ni1) - val;
end

end %func