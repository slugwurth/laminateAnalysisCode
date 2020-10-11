function [Ex,nuxy,Ey,Gxy] = LaminaEngProperties(E1,nu12,E2,G12,Theta)
% LaminaEngProperties calculates engineering properties for an off-axis lamina
%
%   Syntax:
%     [Ex,nuxy,Ey,Gxy] = LaminaEngProperties(E1,nu12,E2,G12,Theta)
%
%   Inputs: 
%     E1 - Young's modulus in the 1-direction
%     nu12 - major Poisson's ratio
%     E2 - Young's modulus in the 2-direction
%     G12 - inplane shear modulus
%     Theta - Angle in degrees from the x-axis to the 1-axis (CCW positive)
%     Note 1 and 2 are the principal material directions.
%     Typically E1, E2 and G12 are specified in SI units of Pa.
%
%   Output: 
%     Ex - Young's modulus in the x-direction
%     nuxy - Poisson's ratio of an off-axis lamina
%     Ey - Young's modulus in the y-direction
%     Gxy - in-plane shear modulus of an off-axis lamina
%
%   Author: Senthil S. Vel, University of Maine
%
%   See also ReducedCompliance, ReducedStiffness, OffAxisCompliance, OffAxisStiffness 

% Calculate the reduced compliance matrix S
S = ReducedCompliance(E1,nu12,E2,G12);

% Calculate the off-axis reduced compliance matrix SBar
SBar = OffAxisCompliance(S,Theta);
SBar11 = SBar(1,1);
SBar12 = SBar(1,2);
SBar22 = SBar(2,2);
SBar66 = SBar(3,3);

% Calculate the effective engineering properties of an off-axis lamina
Ex = 1/SBar11;
Ey = 1/SBar22;
nuxy = -SBar12/SBar11;
Gxy = 1/SBar66;

end
