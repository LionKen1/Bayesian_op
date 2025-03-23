function [mcx,mx] = mncn(varargin)
%MNCN Mean center scales matrix to mean zero
%  Mean centers matrix x, returning a matrix with mean zero
%  columns (mcx) and the vector of means (mx) used in the scaling.
%  I/O format is: [mcx,mx] = mncn(x);
% Ĭ�϶����ݽ������Ļ�and��׼���������flag=1 ��ֻ�������Ļ�����
%  Copyright
%  Barry M. Wise
%  1991
%  Modified November 1993
%1 ���Ļ� and ��׼���׼��
%2 ���Ļ� and �����׼��
x = varargin{1};
if nargin >1
    indice = varargin{2};
else
    indice = 0;
end
%%%%%%%%%%%*****�����ݽ������Ļ�*****%%%%%%%
[m,n] = size(x);
mx(1,:) = mean(x);
mcx = (x-mx(ones(m,1),:));
if indice
    return
end
%%%%%%%%%%*****�����ݽ��б�׼���׼��*****%%%%%%%
mtd1 = std(x); %1 ��׼��
mx(2,:) = mtd1;
mcx = (mcx./mtd1(ones(m,1),:));  %1 ��׼���׼��
% %%%%%%%%%%*****�����ݽ��м����׼��*****%%%%%%%
% mtd2 = max(x)-min(x); %2 ����
% mx(2,:) = mtd2;
% mcx = (mcx./mtd2(ones(m,1),:)); %2 �����׼��
