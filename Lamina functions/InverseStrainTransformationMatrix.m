function [Teinv]=InverseStrainTransformationMatrix(Theta)
% InverseStrainTransformationMatrix computes the inverse of the 
% 2D strain coordinate transformation matrix based on the
% Voigt notation (T_epsilon)
%
%   Syntax:
%     Teinv = InverseStrainTransformationMatrix(Theta)
%
%   Inputs: 
%     Theta - Rotation angle in degrees 
%
%   Output: 
%     Teinv - 3x3 inverse of the 2D strain coordinate transformation matrix
%	      (for the Voigt notation case)
%
%   Author: Senthil S. Vel, University of Maine
%
%   See also StrainTransformationMatrix, StressTransformationMatrix, InverseStressTransformationMatrix

% Cosine and Sine of the angle 
  m = cosd(Theta);
  n = sind(Theta);

% Inverse of the strain transformation matrix
  Teinv =[m^2      n^2     -m*n;
          n^2      m^2      m*n;
          2*m*n  -2*m*n   m^2-n^2];

end
