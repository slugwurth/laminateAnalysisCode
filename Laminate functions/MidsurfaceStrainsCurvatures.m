function [Epsilon0,Kappa] = MidsurfaceStrainsCurvatures(abd,Nx,Ny,Nxy,Mx,My,Mxy)
% MidsurfaceStrainsCurvatures computes the mid-surface strains and curvatures
% of a lamina under loads Nx, Ny and Nxy and moments Mx, My and Mxy based on
% the load-deformation relations: [epsilon,kappa] = [abd] [N,M].
%
%   Syntax:
%     [Epsilon0,Kappa] = MidsurfaceStrainsCurvatures(abd,Nx,Ny,Nxy,Mx,My,Mxy)
%
%   Inputs: 
%     abd - [abd] matrix (i.e. inverse of [ABD]), could be computed using LaminateABD
%     Nx  - x-direction axial load (force)
%     Ny  - y-direction axial load (force)
%     Nxy - xy-plane shear load (force)
%     Mx  - Bending moment about the x-axis
%     My  - Bending moment about the y-axis
%     Mxy - Twisting moment
%
%   Output: 
%     Epsilon0 - Computed mid-surface strain of the laminate
%     Kappa    - Computed mid-surface curvature of the laminate
%
%   Author: Senthil S. Vel, University of Maine
%
%   See also LaminateABD, LaminateStrainsXY, LaminateStressesXY.

% Create a column array of forces and moments
NM = [Nx Ny Nxy Mx My Mxy]';

% Determine the midsurface strains and curvatures array
EpsilonKappaArray = abd*NM;

% Extract the midsurface strains and curvatures
Epsilon0 = EpsilonKappaArray(1:3,1);
Kappa = EpsilonKappaArray(4:6,1);

end
