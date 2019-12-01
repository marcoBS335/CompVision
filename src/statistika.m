% Computer vision statistics
%% Measure times
original = imread('stavebnica.jpg');
if size(original,3)>1
   original = rgb2gray(original); 
end
timesCustom = zeros(1,1000);
timesOpenCV = zeros(1,1000);
for i=1:1000 % test 1000 krat
    tic
    corners = shiTomasiFeatures(original, 5);
    sc = corners.selectStrongest(15);
    timesCustom(i) = toc;
    
    tic
    corners = detectMinEigenFeatures(original);
    sc = corners.selectStrongest(15);
    timesOpenCV(i) = toc;
end
%% Calculate statistics
timesCustom = T.Custom;
timesOpenCV = T.OpenCV;
if vartest2(timesCustom,timesOpenCV)
    %A-W
    if ttest2(timesCustom,timesOpenCV,'Tail','both','Vartype','unequal')
        disp("A-W: at the specified level of significance alpha = 0.05, " +...
        "means of both time samples differ significantly.");
    else
        disp("A-W: at the specified level of significance alpha = 0.05, " +...
        "means of both time samples do not differ significantly.");
    end
else
    %T-TEST
    if ttest2(timesCustom,timesOpenCV,'Tail','both','Vartype','equal')
        disp("T: at the specified level of significance alpha = 0.05, " +...
        "means of both time samples differ significantly.");
    else
        disp("T: at the specified level of significance alpha = 0.05, " +...
        "means of both time samples do not differ significantly.");
    end
end