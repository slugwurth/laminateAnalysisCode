function S = ReducedCompliance(E1,nu12,E2,G12)
% ReducedCompliance calculates the plane stress reduced elastic 
% compliance matrix [S] for a composite lamina.
%
%   Syntax:
%     S = ReducedCompliance(E1,nu12,E2,G12) 
%
%   Inputs: 
%     E1 - Young's modulus in the 1-direction
%     nu12 - major Poisson's ratio
%     E2 - Young's modulus in the 2-direction
%     G12 - inplane shear modulus
%     Note 1 and 2 are the principal material directions.
%     Typically E1, E2 and G12 are specified in SI units of Pa.
%
%   Output: 
%     S - 3x3 reduced complaince matrix for a composite lamina.
%
%   Author: Senthil S. Vel, University of Maine
%
%   See also ReducedStiffness, OffAxisStiffness, OffAxisCompliance.

%   Evaluate the elements of the reduced compliance matrix
	S11 = 1/E1;
	S12 = -nu12/E1;
	S22 = 1/E2;
	S66 = 1/G12;

%   Arrange the elements to form the reduced compliance matrix [S]
	S = [S11  S12  0;
         S12  S22  0; 
          0    0  S66];
      
end


