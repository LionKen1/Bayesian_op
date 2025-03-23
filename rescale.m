function rx = rescale(x,mx,stdx)
%RESCALE Rescales matrix 
%  Rescales a matrix (x) using the means (mx) and standard 
%  deviation (stdx) vectors specified.  I/O format is:
%  rx = rescale(x,mx,stdx);
%  If only two input arguments are supplied the function rescales
%  the means only.  The I/O format is then:
%  rx = rescale(x,mx);

%  Copyright
%  Barry M. Wise
%  1991
%  Modified November 1993

[m,n] = size(x);
if nargin == 3
  rx = (x.*stdx(ones(m,1),:))+mx(ones(m,1),:);
else
  rx = x+mx(ones(m,1),:);
end
