function Te=StrainTransformationMatrix(Theta)
% StrainTransformationMatrix computes the 2D strain coordinate 
% transformation matrix based on the Voigt notation (T_epsilon)
%
%   Syntax:
%     Te = StrainTransformationMatrix(Theta)
%
%   Inputs: 
%     Theta - Rotation angle in degrees 
%
%   Output: 
%     Te - 3x3 2D strain coordinate transformation matrix
%	       (based on the Voigt notation)
%
%   Author: Senthil S. Vel, University of Maine
%
%   See also InverseStressTransformationMatrix, StressTransformationMatrix, InverseStrainTransformationMatrix

% Cosine and Sine of the angle 
  m = cosd(Theta);
  n = sind(Theta);

% Strain transformation matrix T_epsilon
  Te =[ m^2    n^2    m*n;
        n^2    m^2   -m*n;
      -2*m*n  2*m*n  m^2-n^2 ];
  
end
