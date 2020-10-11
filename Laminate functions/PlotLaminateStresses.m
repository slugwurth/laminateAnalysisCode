function PlotLaminateStresses(ComponentStr,ThetaArray,QBarArray,ZArray,Epsilon0,Kappa0,H)
% PlotLaminateStressess plots the through-the-thickness variation 
% (i.e. as a function of z) of a specifiec stress component in the laminate 
%
%   Syntax:
%     PlotLaminateStresses(ComponentStr,ThetaArray,QBarArray,ZArray,Epsilon0,Kappa0,H)
%
%   Inputs: 
%     ComponentStr - Stress component to be plotted, takes one of the following 
%                    character array values: 
%                    in the golbal/structural coordinate system: 'sx', 'sy', 'tauxy' 
%                    in the principal/material coordiante system: 's1', 's2', 'tau12'
%     ThetaArray   - Nx1 vector of layer fiber orientations, where N is the number 
%                    of layers in the laminate.
%     QBarArray    - An array where QBarArray{k} is a 3x3 matrix of off-axis 
%                    stiffnesses of the kth layer of the laminate
%     ZArray       - Array of interface z-coordinates of a laminate
%     Epsilon0     - Mid-surface strains of the laminate
%     Kappa0       - Mid-surface curvatures of the laminate
%     H            - Total height, i.e. thickness, of the laminate
%
%   Output: 
%     No outputs for this function (except the plot outputs as figures)
%
%   Author: Senthil S. Vel, University of Maine
%
%   See also LaminateStressesXY, PlotLaminateStrains, PlotLaminateTsaiWuSfr .

% Read global plot parameters
global LineThickness 

% Determine the number of layers from the ZArray
N = length(QBarArray);

% Specify the number of sampling points per layer for the plots
PointsPerLayer  = 2;

switch ComponentStr
    case 'sx'
        CoordinateSystem ='XY';
        Component = 1;
        xstr = 'Normal Stress $\sigma_{\textit{x}}$ (MPa)';
        FigName = 'Normal stress sigma_x';
    case 'sy'
        CoordinateSystem ='XY';
        Component = 2;
        xstr = 'Normal Stress $\sigma_{\textit{y}}$ (MPa)';
        FigName = 'Normal stress sigma_y';
    case 'tauxy'
        CoordinateSystem ='XY';
        Component = 3;
        xstr = 'Shear stress $\tau_{\textit{xy}}$ (MPa)';
        FigName = 'Shear stress tau_xy';
    case 's1'
        CoordinateSystem ='12';
        Component = 1;
        xstr = 'Normal Stress $\sigma_{1}$ (MPa)';
        FigName = 'Normal stress sigma_1';
    case 's2'
        CoordinateSystem ='12';
        Component = 2;
        xstr = 'Normal Stress $\sigma_{2}$ (MPa)';
        FigName = 'Normal stress sigma_2';
    case 'tau12'
        CoordinateSystem ='12';
        Component = 3;
        xstr = 'Shear stress $\tau_{12}$ (MPa)';
        FigName = 'Shear stress tau_12';
end

% Clear figure and hold while plotting
figure('Name',FigName);
clf;
hold on;

for k = 1:N
    % Sample points from Z(k)-eps to Z(k+1)+eps. The eps is used to 
    % avoid ambiguity of which layer the interface belongs to. Use a very 
    % small value for the parameter eps to ensure points close to the 
    % interfaces are included in the plots
    zloc = linspace(ZArray(k)+eps,ZArray(k+1)-eps,PointsPerLayer);
    
    % Evaluate the stresses at the sampling points
    for n = 1: PointsPerLayer
        switch CoordinateSystem
            case 'XY'
              % Evaluate stresses in the XY coordinate system
              StressColumnArray = LaminateStressesXY(QBarArray,ZArray,Epsilon0,Kappa0,zloc(n));
            case '12'
              % Evaluate stresses in the XY coordinate system
              StressesXY = LaminateStressesXY(QBarArray,ZArray,Epsilon0,Kappa0,zloc(n));
              % Transform stresses to the 1-2 coordinate system
              Ts=StressTransformationMatrix(ThetaArray(k));
              StressColumnArray = Ts*StressesXY; 
        end
        % Extract the stress component of interest
        Stress(n) = StressColumnArray(Component);
    end
    
    % plot the stress variation in layer k
    hp = plot(Stress/1e6,zloc/H,'k-','LineWidth',LineThickness,'LineJoin','round');
end

% Insert axes labels
xlabel(xstr,'Interpreter','latex');
ylabel('$z/H$','Interpreter','latex');

% Format the laminate plot
FormatLaminatePlot(ZArray)

end
