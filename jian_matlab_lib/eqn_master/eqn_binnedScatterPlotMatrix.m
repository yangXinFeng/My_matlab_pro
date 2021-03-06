function [matrix, xticks, yticks, xbins, ybins] = eqn_binnedScatterPlotMatrix(x, y, no_of_x_bins, no_of_y_bins, ...
    x_lims, y_lims, isInt, norm, supressPlotting)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if sum(size(x) == size(y)) ~= 2
    error('X and Y vectors have unequal dimensions');
end

if nargin < 9; supressPlotting = false; end
if nargin < 8; norm = false; end
if nargin < 7; isInt = [false, false]; end
if nargin < 6; y_lims = [min(y), max(y)]; end
if nargin < 5; x_lims = [min(x), max(x)]; end
if nargin < 4; no_of_y_bins = 10; end
if nargin < 3; no_of_x_bins = 10; end
if nargin < 2; error('Too few input arguments'); end

xbins = linspace(x_lims(1), x_lims(end), no_of_x_bins+1-isInt(1));
ybins = linspace(y_lims(1), y_lims(end), no_of_y_bins+1-isInt(2));

% find bin width (if 0, set to 1 to avoid divide_by_zero errors!)
dxbins = xbins(2) - xbins(1);
if dxbins == 0; dxbins = 1; end
dybins = ybins(2) - ybins(1);
if dybins == 0; dybins = 1; end

% remove points that fall outside the bin lims
fx = find(x<xbins(1) | x>xbins(end) | isnan(x));
if ~isempty(fx); x(fx) = []; y(fx) = []; end
fy = find(y<ybins(1) | y>ybins(end) | isnan(y));
if ~isempty(fy); x(fy) = []; y(fy) = []; end

xinds = fix((x - xbins(1)) / dxbins) + 1;
xinds(xinds == no_of_x_bins + 1) = no_of_x_bins; % final bin should include the max values
yinds = fix((y - ybins(1)) / dybins) + 1;
yinds(yinds == no_of_y_bins + 1) = no_of_y_bins; % final bin should include the max values

matrix = zeros(no_of_y_bins, no_of_x_bins);
for i=1:length(xinds)
    matrix(yinds(i), xinds(i)) = matrix(yinds(i), xinds(i)) + 1;
end

if norm; matrix = bsxfun(@rdivide, matrix, sum(matrix,1)); end;

if isInt(1)
    xticks = (1:1:no_of_x_bins)';
else
    xticks = (.5:1: no_of_x_bins+0.5)';
end
if isInt(2)
    yticks = (1:1:no_of_y_bins)';
else
    yticks = (.5:1: no_of_y_bins+0.5)';
end

if ~supressPlotting
    imagesc((1:1:no_of_x_bins), (1:1:no_of_y_bins), matrix);
    % contourf((1:1:no_of_x_bins), (1:1:no_of_y_bins), matrix)
    colorbar;
    set(gca, 'ydir', 'normal');
    set(gca, 'xlim', [0.5, no_of_x_bins+0.5], 'xtick', xticks, 'xticklabel', xbins);
    set(gca, 'ylim', [0.5, no_of_y_bins+0.5], 'ytick', yticks, 'yticklabel', ybins);
end

end

