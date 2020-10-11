function Q = ReducedStiffness(E1,nu12,E2,G12)
% ReducedStiffness calculates the plane stress reduced elastic 
% stiffness matrix [Q] for a composite lamina.
%
%   Syntax:
%     Q = ReducedStiffness(E1,nu12,E2,G12) 
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
%     Q - 3x3 reduced stiffness matrix for a composite lamina
%
%   Author: Senthil S. Vel, University of Maine
%
%   See also ReducedCompliance, OffAxisStiffness, OffAxisCompliance.

%   Calculate the minor Poisson's ratio using the reciprocal relations
	nu21 = nu12*E2/E1;
    
%   Evaluate the elements of the reduced stiffness matrix
	Q11 = E1/(1-nu12*nu21);
	Q12 = nu12*E2/(1-nu12*nu21);
	Q22 = E2/(1-nu12*nu21);
	Q66 = G12;

%   Arrange the elements to form the reduced stiffness matrix [Q]
    Q = [Q11  Q12  0;
         Q12  Q22  0; 
          0    0  Q66];
      
end