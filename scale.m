function sx = scale(x,means,stds)
%SCALE Scales matrix as specified
%  Scales a matrix (x) using means (mx) and standard 
%  deviations (stds) specified.  
%  I/O format is:  sx = scale(x,mx,stdx);
%  If only two input arguments are supplied then the function
%  will not do variance scaling, but only vector subtraction.
%  I/O format is:  sx = scale(x,mx);

%  Copyright
%  Barry M. Wise
%  1991
%  Modified November 1993 

[m,n] = size(x);
if nargin == 3
  sx = (x-means(ones(m,1),:))./stds(ones(m,1),:);
else
  sx = (x-means(ones(m,1),:));
end
