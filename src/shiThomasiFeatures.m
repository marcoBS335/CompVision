function corners = shiThomasiFeatures(original, varargin)
% returns the corners of an image that are above a certain treshold 
% corners = shiThomasiFeatures(original)
%
% corners = shiThomasiFeatures(original, filterSize)
% the default value of filterSize is 5
% 
% corners = shiThomasiFeatures(original, filterSize, treshold)
% the default value of treshold is 100

filterSize = 5;
treshold = 100;

if nargin > 1
    if ~isa(varargin{1},'double')
        error('Filter size must be a numeric value');
    end
    if mod(varargin{1},2)==0 || varargin{1} < 3
        error('Filter size must be larger than 3 and odd.');
    end
    filterSize = varargin{1};
end
if nargin > 2
    if ~isa(varargin{2},'double')
        error('Treshold must be a numeric value');
    end
    treshold = varargin{2};
end
if nargin > 3
    error('Too many input parameters');
end

% padding the image
original = padarray(original, [5, 5]);
original([1:5,end-4:end],:)=original(6,6);
original(:,[1:5,end-4:end])=original(6,6);

% casting the image to double
originald = double(original);

sigma=fix(filterSize)/3; % yields similar results to shi-tomasi matlab fnc


% ---- USING CONV2 ----
% [dx,dy]=meshgrid(linspace(-1,1,4),linspace(-1,1,4));
% Ix=conv2(double(originald),0.5*dx,'same');
% Iy=conv2(double(originald),0.5*dy,'same');
% Ix = Ix(2:end-1,2:end-1);
% Iy = Iy(2:end-1,2:end-1);
% g = fspecial('gaussian',max(1,fix(filterSize)), sigma);
% Ix2=conv2(Ix.^2,g,'same');
% Iy2=conv2(Iy.^2,g,'same');
% IxIy=conv2(Ix.*Iy,g,'same');


% ---- USING IMFILTER ---- 
% seems to imitate the matlab fnc more closely than conv2 approach

Ix = imfilter(originald,[-1 0 1],'replicate','same','conv');
Iy = imfilter(originald,[-1;0;1],'replicate','same','conv');
% Ix = Ix(2:end-1,2:end-1);
% Iy = Iy(2:end-1,2:end-1);
g = fspecial('gaussian',max(1,fix(filterSize)), sigma);
Ix2=imfilter(Ix.^2,g  ,'replicate','same','conv');
Iy2=imfilter(Iy.^2,g  ,'replicate','same','conv');
IxIy=imfilter(Ix.*Iy,g,'replicate','same','conv');



% R11 = ( (Ix2 + Iy2) - sqrt((Ix2 - Iy2).^2 + 4*(IxIy).^2) ) / 2;
% R11=(1000/max(max(R11)))*R11; % scaling
% R=R11;
R = ( (Ix2 + Iy2) - sqrt((Ix2 - Iy2).^2 + 4*(IxIy).^2) ) / 2;

% removing edges of image
R([1:5,end-4:end],:) = 0;
R(:,[1:5,end-4:end]) = 0;

% calculating local maxima using ordfilt
LocalMaxima = ordfilt2(R,3^2,true(3));
% mesh(R)

% calculating the location of corners
[rows,cols] = find((R>treshold)&(R==LocalMaxima));

% calculating the metric for cornerPoints
metric = zeros(size(rows));
for i = 1:size(rows)
    metric(i) = R(rows(i),cols(i));
end
corners = cornerPoints([cols-5,rows-5],'Metric',metric);
end