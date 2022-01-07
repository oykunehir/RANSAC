
%% Create data of a linear model  y = ax + b (2D)
a = 20;
b = 5;
%% Build dataset
P = [ ];
for x = -15 :0.5: 15
  y = (a*x)/b;
  %% Add Noise %fix noise
  x = x+randi(10,1,1);
  y = y+randi(10,1,1);
  %% get data points
  P = [P; x,y];
end
%% Add outliers
outlier = [15,0; 4,10; -10,10; -12,15;
     10,0; 30,0; -30,0; -20,0; ];
P = [P;outlier];

%% plot points
figure(1);
for i=1:length(P)
    plot(P(i,1),P(i,2),'*', 'color', [0.5000    0.5000    1.0000])
    hold on;
end
axis([-80 80 -80 80])
[t1 , t2] = title('search for inliers in random data + noise + outliers', 'The inliers solution is the points obtained in GREEN');

%% Ransac
number_of_iterations = 5
[M, B, solution] = RANSAC(P, number_of_iterations);


%% ---------------------------- BONUS, plus ------------------------------------------------------------
%% get the best 3 models that fit inliers
m_error = [ ];
b_error = [ ];
for i = 1:length(M)
    m_error(i) = abs(M(i) - a);
    b_error(i) = abs(B(i) - b);
end
m_error2 = sort(m_error);
b_error2 = sort(b_error);

a_best_error1 = m_error2(1);
a_best_error2 = m_error2(2);
a_best_error3 = m_error2(3);

b_best_error1 = b_error2(1);
b_best_error2 = b_error2(2);
b_best_error3 = b_error2(3);

for i = 1:length(M)
    if a_best_error1 == m_error(i)
        aindex1 = i;
    end
    if a_best_error2 == m_error(i)
        aindex2 = i;
    end
    if a_best_error3 == m_error(i)
        aindex3 = i;
    end
end

for i = 1:length(B)
    if b_best_error1 == b_error(i)
        bindex1 = i;
    end
    if b_best_error2 == b_error(i)
        bindex2 = i;
    end
    if b_best_error3 == b_error(i)
        bindex3 = i;
    end
end
%% models are :
m1 = M(aindex1);
b1 = B(bindex1);
m2 = M(aindex2);
b2 = B(bindex2);
m3 = M(aindex3);
b3 = B(bindex3);
