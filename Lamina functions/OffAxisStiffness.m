function QBar = OffAxisStiffness(Q,Theta)
% OffAxisStiffness calculates the plane stress reduced elastic 
% stiffness matrix [QBar] for an off-axis composite lamina.
%
%   Syntax:
%     QBar = OffAxisStiffness(Q,Theta) 
%
%   Inputs: 
%     Q - 3x3 plane-stress reduced stiffness matrix for a composite lamina
%     Theta - Angle in degrees from the x-axis to the 1-axis (CCW positive)
%
%   Output: 
%     QBar - 3x3 reduced stiffness matrix for an off-axis lamina
%
%   Author: Senthil S. Vel, University of Maine
%
%   See also ReducedCompliance, ReducedStiffness, OffAxisCompliance.

% Cosine and Sine of the angle
  m = cosd(Theta);
  n = sind(Theta);

% 2D reduced stiffness matrix (Q) values extraction
  Q11 = Q(1,1); Q12 = Q(1,2); Q22 = Q(2,2); Q66 = Q(3,3); 

% Calculate the off-axis stiffnesses QBar
  QBar11 = Q11*m^4+2*(Q12+2*Q66)*m^2*n^2+Q22*n^4;
  QBar12 = (Q11+Q22-4*Q66)*m^2*n^2+Q12*(m^4+n^4);
  QBar16 = (Q11-Q12-2*Q66)*n*m^3+(Q12-Q22+2*Q66)*n^3*m;
  QBar22 = Q11*n^4+2*(Q12+2*Q66)*n^2*m^2+Q22*m^4;
  QBar26 = (Q11-Q12-2*Q66)*n^3*m+(Q12-Q22+2*Q66)*n*m^3;
  QBar66 = (Q11+Q22-2*Q12-2*Q66)*n^2*m^2+Q66*(n^4+m^4);

% Assemble the QBar matrix
  QBar =[QBar11 QBar12 QBar16; 
         QBar12 QBar22 QBar26; 
         QBar16 QBar26 QBar66];
     
end
