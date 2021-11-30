
function [M, B, solutionInliers] = RANSAC(P, nrIterations)
solutionInliers = [ ];
bestError = Inf;
filename = 'ransac.gif';
M = [ ];
B =[ ];
%% simulation
for k = 1:nrIterations
    frame = getframe(1);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    if k == 1;
        imwrite(imind,cm,filename,'gif','DelayTime',0.1,'Loopcount',inf);
    else
        imwrite(imind,cm,filename,'gif','DelayTime',0.01,'WriteMode','append');
    end
    
    %% ------------------------------------------RANSAC--------------------------------------------------
    %% 1.Select random data from the entire dataset
    nrPoints = length(P);
    samples = datasample(P,2); % Sample the data
    p1 = samples(1,:);
    p2 = samples(2,:);
    ph1 = plot(p1(1),p1(2),'bo', 'MarkerSize',15)
    ph2 = plot(p2(1),p2(2),'bo', 'MarkerSize',15)
    %% 2.Calculate the parameters of the model using the selected data
    m = (p2(2) - p1(2))/(p2(1)-p1(1)); % m = (y2-y1)/(x2-x1)
    b = p1(2) - m*p1(1); % b = y1 - m*x1
    M(k) = m; %store m
    B(k) = b; %store b
    Ps = [ ];
    %Plot the obtained model mx+b = y
    for x=-15:0.5:15
      y = (m/b)*x;
      Ps = [Ps; x,y];
    end
    %lh = line(Ps(:,1),Ps(:,2),'color','r')
    %% 3.check if the selected data is suitable for the model
    delta = 3;  %threshold
    %Score
    pH = [ ];
    inliers = [ ];
    error = 0;
    %% simulation
    for i = 1:nrPoints
      x = P(i,1);
      y = P(i,2);
      h = plot(x,y,'ro', 'MarkerSize',15);
      frame = getframe(1);
      im = frame2im(frame);
      [imind,cm] = rgb2ind(im,256);
      imwrite(imind,cm,filename,'gif','DelayTime',0.01,'WriteMode','append');
      %% Compute the distance to the line model
      dist = abs(y - m*x - b)/sqrt(1 + m^2);
      %% If the distance is less than our threshold delta
      if(dist < delta)
          %% Accept data, add to the inlier set
          inliers = [inliers; x y];
          ha = plot(x,y,'g*');
          pH = [pH; ha];
      else
          %% compute cumulative error
          error = error + dist;
          ha = plot(x,y,'r*');
          pH = [pH; ha];
      end
      %% Simulation
      frame = getframe(1);
      im = frame2im(frame);
      [imind,cm] = rgb2ind(im,256);
      imwrite(imind,cm,filename,'gif','DelayTime',0.01,'WriteMode','append');
      delete(h)
    end
    %% check if the obtained SOLUTION (Inliers data) is suitable for our model
    if(error < bestError)
      solutionInliers = inliers;
      bestError = error
    end
    delete(pH);
    %delete(lh);
    delete(ph1);
    delete(ph2);
  end
  
%% Plot inliers data solution
for i = 1:length(solutionInliers)
x = solutionInliers(i,1);
y = solutionInliers(i,2);
h = plot(x,y,'go', 'MarkerSize',15);
end
frame = getframe(1);
im = frame2im(frame);
[imind,cm] = rgb2ind(im,256);
imwrite(imind,cm,filename,'gif','WriteMode','append');
end
