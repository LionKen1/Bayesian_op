function [mcx,mx] = mncn(varargin)
%MNCN Mean center scales matrix to mean zero
%  Mean centers matrix x, returning a matrix with mean zero
%  columns (mcx) and the vector of means (mx) used in the scaling.
%  I/O format is: [mcx,mx] = mncn(x);
% 默认对数据进行中心化and标准化处理；如果flag=1 则只采用中心化处理
%  Copyright
%  Barry M. Wise
%  1991
%  Modified November 1993
%1 中心化 and 标准差标准化
%2 中心化 and 极差标准化
x = varargin{1};
if nargin >1
    indice = varargin{2};
else
    indice = 0;
end
%%%%%%%%%%%*****对数据进行中心化*****%%%%%%%
[m,n] = size(x);
mx(1,:) = mean(x);
mcx = (x-mx(ones(m,1),:));
if indice
    return
end
%%%%%%%%%%*****对数据进行标准差标准化*****%%%%%%%
mtd1 = std(x); %1 标准差
mx(2,:) = mtd1;
mcx = (mcx./mtd1(ones(m,1),:));  %1 标准差标准化
% %%%%%%%%%%*****对数据进行极差标准化*****%%%%%%%
% mtd2 = max(x)-min(x); %2 极差
% mx(2,:) = mtd2;
% mcx = (mcx./mtd2(ones(m,1),:)); %2 极差标准化
