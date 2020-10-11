function [A,B,D,ABD,a,b,d,abd]=LaminateABD(N,QBarArray,ZArray)
% LaminateABD computes the [A], [B], [D] and [ABD] matrices of a laminate.
% In addition, it computes the [a], [b], [d] and [abd] matrices where [abd] is
% the inverse of [ABD].
%
%   Syntax:
%     [A,B,D,ABD,a,b,d,abd] = LaminateABD(N,QBarArray,ZArray)
%
%   Inputs: 
%     N         - Number of layers in the laminate
%     QBarArray - An array where QBarArray{k} is a 3x3 matrix of off-axis 
%                 stiffnesses of the kth layer of the laminate
%     ZArray    - Array of interface z-coordinates of a laminate
%
%   Output: 
%     A   - [A] matrix (3x3)
%     B   - [B] matrix (3x3)
%     D   - [D] matrix (3x3)
%     ABD - [ABD] matrix (6x6)
%     a   - [a] matrix (3x3)
%     b   - [b] matrix (3x3)
%     d   - [d] matrix (3x3)
%     abd - [abd] matrix, inverse of ABD (6x6)
%
%   Author: Senthil S. Vel, University of Maine
%
%   See also LaminateStrainsXY, LaminateStressesXY, LaminateEngineeringProperties.

% Initialize the A, B and D matrices
A=zeros(3,3);
B=zeros(3,3);
D=zeros(3,3);

% Perform layer by layer summation to obtain the A, B and D matrices
for k = 1:N
   A = A + (ZArray(k+1)-ZArray(k))*QBarArray{k}; 
   B = B + (1/2)*((ZArray(k+1))^2-(ZArray(k))^2)*QBarArray{k}; 
   D = D + (1/3)*((ZArray(k+1))^3-(ZArray(k))^3)*QBarArray{k}; 
end

% Arrange the A, B and D into a 6x6 ABD matrix
ABD = [A B; B D];

% Find the inverse of the ABD matrix
abd = inv(ABD);
a = abd(1:3,1:3);
b = abd(1:3,4:6);
c = abd(4:6,1:3);
d = abd(4:6,4:6);

end
