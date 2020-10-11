function [SfrMin,kmin,zmin] = PlotLaminateTsaiWuSfr(F1t,F1c,F2t,F2c,F6,ThetaArray,QBarArray,ZArray,Epsilon0,Kappa0,H)
% PlotLaminateTsaiWuSfr plots the through-the-thickness variation (i.e. as a function of z)
% of the Tsai-Wu reversed-in-sign factor of safety for given mid-surface strains and 
% curvatures in a laminate. It also outputs the minimum factor of safety, its 
% z-location and the layer of the laminate it occurs in.
%
%   Syntax:
%     PlotLaminateTsaiWuSfr(S1t,S1c,S2t,S2c,S6,ThetaArray,QBarArray,ZArray,Epsilon0,Kappa0,H)
%
%   Inputs: 
%     F1t        - Tensile strength in the 1-direction (principal coordinate system)
%     F1c        - Compressive strength in the 1-direction (principal coordinate system) 
%     F2t        - Tensile strength in the 2-direction (principal coordinate system) 
%     F2c        - Compressive strength in the 2-direction (principal coordinate system) 
%     F6         - Shear strength in the 1-2 plane (principal coordinate system)
%     ThetaArray - Nx1 vector of layer fiber orientations, where N is the number 
%                  of layers in the laminate.
%     QBarArray  - An array where QBarArray{k} is a 3x3 matrix of off-axis 
%                  stiffnesses of the kth layer of the laminate
%     ZArray     - Array of interface z-coordinates of a laminate
%     Epsilon0   - Mid-surface strains of the laminate
%     Kappa0     - Mid-surface curvatures of the laminate
%     H          - Total height, i.e. thickness, of the laminate
%
%   Output: 
%     SfrMin - Minimum Tsai-Wu factor of safety (reversed-in-sign)
%     kmin   - Minimum Tsai-Wu factor of safety (reversed-in-sign) layer of occurence
%     zmin   - Minimum Tsai-Wu factor of safety (reversed-in-sign) location (height) of occurence
%     Also the plots are an output
%
%   Author: Senthil S. Vel, University of Maine
%
%   See also PlotLaminateStresses, PlotLaminateStrains, PlotLaminateTsaiWuSfa .

% Read global plot parameters
global LineThickness 

% Determine the number of layers from the QBarArray
N = length(QBarArray);

% Specify the number of sampling points per layer for the plots
PointsPerLayer  = 500;

% Prepare the figure
figure('Name','Reversed-in-sign safety factor |Sfr|');
clf;
hold on;

% Initialize the minimum safety factor value
SfrMin = inf;

for k = 1:N
    % Sample points from Z(k)-eps to Z(k+1)+eps. The eps is used to 
    % avoid ambiguity of which layer the interface belongs to. Use a very 
    % small value for the parameter eps to ensure points close to the 
    % interfaces are included in the plots
    eps = 1e-12;  
    zloc = linspace(ZArray(k)+eps,ZArray(k+1)-eps,PointsPerLayer);
    
    % Evaluate the safety factor at the sampling points
    for n = 1: PointsPerLayer
        % Evaluate stresses in the XY coordinate system
        StressesXY = LaminateStressesXY(QBarArray,ZArray,Epsilon0,Kappa0,zloc(n));
       
        % Transform stresses to the 1-2 coordinate system
        Ts=StressTransformationMatrix(ThetaArray(k));
        Stresses12 = Ts*StressesXY; 
        
        % Calculate the safety factor
        [Sfa(n), Sfr(n)]=TsaiWu(F1t,F1c,F2t,F2c,F6,Stresses12);
        
        % Update the min safety factor values
        if abs(Sfr(n)) < SfrMin
            SfrMin = abs(Sfr(n));
            zmin = zloc(n);
            kmin = k;
        end       
    end
    
    % plot the safety factor variation in layer k
    plot(abs(Sfr),zloc/H,'k-','LineWidth',LineThickness);
end

% Insert axes labels
xlabel('Safety factor $|S_{fr}|$','Interpreter','latex');
ylabel('$z/H$','Interpreter','latex');

% Format the laminate plot
FormatLaminatePlot(ZArray);

end

