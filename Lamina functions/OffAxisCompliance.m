function SBar = OffAxisCompliance(S,Theta)
% OffAxisCompliance calculates the plane stress reduced elastic 
% compliance matrix [SBar] for an off-axis composite lamina.
%
%   Syntax:
%     SBar = OffAxisCompliance(S,Theta)
%
%   Inputs: 
%     S - 3x3 plane-stress reduced compliance matrix for a composite lamina
%     Theta - Angle in degrees from the x-axis to the 1-axis (CCW positive)
%
%   Output: 
%     SBar - 3x3 reduced complaince matrix for an off-axis lamina
%
%   Author: Senthil S. Vel, University of Maine
%
%   See also ReducedCompliance, ReducedStiffness, OffAxisStiffness.

% Cosine and Sine of the angle
  m = cosd(Theta);
  n = sind(Theta);

% 2D reduced compliance matrix (S) values extraction
  S11 = S(1,1); S12 = S(1,2); S22 = S(2,2); S66 = S(3,3); 

% Calculate the off-axis compliances SBar
  SBar11 = S11*m^4+(2*S12+S66)*m^2*n^2+S22*n^4;
  SBar12 = (S11+S22-S66)*m^2*n^2+S12*(m^4+n^4);
  SBar16 = (2*S11-2*S12-S66)*n*m^3+(2*S12-2*S22+S66)*n^3*m;
  SBar22 = S11*n^4+(2*S12+S66)*n^2*m^2+S22*m^4;
  SBar26 = (2*S11-2*S12-S66)*n^3*m+(2*S12-2*S22+S66)*n*m^3;
  SBar66 = 2*(2*S11+2*S22-4*S12-S66)*n^2*m^2+S66*(n^4+m^4);

% Assemble the SBar matrix
  SBar =[SBar11 SBar12 SBar16; 
         SBar12 SBar22 SBar26; 
         SBar16 SBar26 SBar66];
     
end
