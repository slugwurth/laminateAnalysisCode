function FormatLaminatePlot(ZArray)
% FormatLaminatePlot sets up the figure characteristics
% for the through-the-thickness plots for a laminate
%
%   Syntax:
%     FormatLaminatePlot(ZArray, FontSize)
%
%   Inputs: 
%     ZArray - Array of interface z-coordinates of a laminate
%
%   Output: 
%     No output, the plot through-thickness aesthetics will be modified
%
%   Author: Senthil S. Vel, University of Maine

% Read global variables
global LineThickness FontSize
global InterfaceLineColor MidsurfaceLineColor VerticalAxisLineColor

% Number of layers
N = length(ZArray)-1;

% Laminate thickness
H = ZArray(N+1)-ZArray(1);

% Set the plot box aspect ratio
pbaspect([1.618 1 1])

% Get axis range
V = axis;

% Change the axis settings to make the figure more readable
ha = gca;
set(ha,'Box','on');
set(ha,'FontSize',FontSize); 
set(ha,'LineWidth',LineThickness/2);

% Draw the mid-surface
x =[V(1); V(2)];  % The line extends over the entire horizontal range
y = [0;0];
hl = line(x,y);
set(hl,'LineStyle','--')
set(hl,'Color',MidsurfaceLineColor);
set(hl,'LineWidth',LineThickness/4);
uistack(hl,'bottom');

% Plot horizontal lines corresponding to the bottom surface, top
% surface and interface
for k = 2:N
    x =[V(1); V(2)];  % The line extends over the entire horizontal range
    y = [ZArray(k)/H; ZArray(k)/H];
    hl = line(x,y);
    set(hl,'Color',InterfaceLineColor);
    set(hl,'LineWidth',LineThickness/4);
    uistack(hl,'bottom'); 
    %get(hl)
    %set(hl,'Visible')
end

% Draw the vertical line corresponding to VAxisValue
x =[0; 0];  
y = [V(3);V(4)]; % The line extends over the entire vertical range
hl = line(x,y);
set(hl,'LineStyle','-')
set(hl,'Color',VerticalAxisLineColor);
set(hl,'LineWidth',LineThickness/4);
uistack(hl,'bottom');

% Show labels for the interface locations if there are less than 10 layers
if N < 10  
    % Set yticks
    yticks(ZArray/H);
    
    % Set ytick labels
    [Num,Den]=rat(ZArray/H);
    for k = 1:N+1
        if Num(k) == 0
            YTickLabelStr{k} = '0';
        else
            YTickLabelStr{k} =strcat(num2str(Num(k)),'/',num2str(Den(k)));
        end
        yticklabels(YTickLabelStr)
    end
else
    % Show only the bottom surface, midsurface and top surface labels
    % if there are more than 10 layers so that the ytick labels are not 
    % too cluttered.
    yticks([-1/2 0 1/2]);
end

% Reset axis range
axis(V);
end

