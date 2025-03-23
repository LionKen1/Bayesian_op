nums = 10;ita = 5;
mse_pcr = zeros(15-nums,ita);
mse_pls = zeros(15-nums,ita);
mse_bp = zeros(15-nums,ita);
addr='C:\Users\t1714\Desktop\Academic\toolbox assembly\pls_tool-tem';
addpath(genpath(addr)) ;
for i_g = 1:ita
% clear
clc
close all
input = xlsread('data(1).xls', 'input', 'A1:CW7');
output = xlsread('data(1).xls', 'output', 'A1:CW134');
col_converge = [2,3,6,7,21,25,26,62,66,80,86,87,91,92,93]';
input_x = [];
output_y = [];
for i = 1:size(col_converge,1)
    input_x = [input_x;input([2:5 7],col_converge(i))'];
    output_y = [output_y;output(2:end,col_converge(i)+1)'];
end
%%output_y = 10.^(output_y);
output_y(output_y < 1e-5) = 0;
[x_norm,x_nSP] = mncn(input_x);
[y_norm,y_nSP] = mncn(output_y);

%%%***********************************************train***********************************************%%%%
ind = randperm(15,nums);
D = x_norm(ind,:); D_y = y_norm(ind,:);
%%[p,q,w,t,u,b,ssqdif] = pls(D,D_y,5);
[plsss,cplsss,mlv,bpls] = plscvblk(D,D_y,5,5,1);  %******************pls
%%[t,p,b] = pcr1(D,D_t,5);
[pcrss,cpcrss,mpc,bpcr] = pcrcvblk(D,D_y,5,5,1); %******************pcr
[train_x,xs]=mapminmax(D',0 ,1);
[train_y,ys]=mapminmax(D_y',0 ,1);
hiddennum = 6;
bpnet = newff(train_x,train_y,hiddennum); % fitnet
%%bpnet.trainParam.lr = 0.00001;

for i = 1:20
    ind1 = floor(linspace(1,size(D,1),0.7*size(D,1)));
    train_x1 = train_x(:,ind1); train_y1 = train_y(:,ind1);
    train_x1 = train_x1+rand(size(train_x1))*1e-3;  train_y1 = train_y1+rand(size(train_y1))*1e-3;
    [bpnet,~] = train(bpnet,train_x1,train_y1); %******************bp
end

%%y_norm = y_norm';
%%%***********************************************test***********************************************%%%%
ind_re = setdiff([1:15],ind);
input_test = input_x(ind_re,:); output_test = output_y(ind_re,:);
Dte = scale(input_test,x_nSP(1,:),x_nSP(2,:));
ypls = Dte*bpls;
ypcr = Dte*bpcr;
sypcr = rescale(ypcr,y_nSP(1,:),y_nSP(2,:));
sypls = rescale(ypls,y_nSP(1,:),y_nSP(2,:));
test_x = mapminmax('apply',Dte',xs);
pre_y = sim(bpnet,test_x);
pre_y = mapminmax('reverse',pre_y,ys);
sybp = rescale(pre_y',y_nSP(1,:),y_nSP(2,:));
clear bpnet
% figure;
% hold on
s = 1:size(output_test,2);
% plot(s,output_test(1,:),':rd',s,sypcr(1,:),'-b*');
% title('Actual (diamond) and Fitted by PCA (star)');
% legend('Actual','Predicated');
% figure;
% plot(s,output_test(2,:),':rd',s,sypcr(2,:),'-b*');
% title('Actual (diamond) and Fitted by PCA (star)');
% legend('Actual','Predicated');
% figure;
% plot(s,output_test(3,:),':rd',s,sypcr(3,:),'-b*');
% title('Actual (diamond) and Fitted by PCA (star)');
% legend('Actual','Predicated');

% plot(s,output_test(1,:),':rd',s,sypcr(1,:),'-r*');
% plot(s,output_test(2,:),':bd',s,sypcr(2,:),'-b*');
% plot(s,output_test(3,:),':gd',s,sypcr(3,:),'-g*');
% plot(s,output_test(4,:),':cd',s,sypcr(4,:),'-c*');
% plot(s,output_test(5,:),':kd',s,sypcr(5,:),'-k*');
% title('Actual (diamond) and Fitted by PCA (star)');
% legend('Actual','Predicated');

% figure;
% plot(s,output_test(1,:),':rd',s,sypls(1,:),'-b*');
% title('Actual (diamond) and Fitted by PLS (star)');
% legend('Actual','Predicated');
% figure;
% plot(s,output_test(2,:),':rd',s,sypls(2,:),'-b*');
% title('Actual (diamond) and Fitted by PLS (star)');
% legend('Actual','Predicated');
% figure;
% plot(s,output_test(3,:),':rd',s,sypls(3,:),'-b*');
% title('Actual (diamond) and Fitted by PLS (star)');
% legend('Actual','Predicated');
% figure;
% hold on
% plot(s,output_test(1,:),':rd',s,sypls(1,:),'-r*');
% plot(s,output_test(2,:),':bd',s,sypls(2,:),'-b*');
% plot(s,output_test(3,:),':gd',s,sypls(3,:),'-g*');
% plot(s,output_test(4,:),':cd',s,sypls(4,:),'-c*');
% plot(s,output_test(5,:),':kd',s,sypls(5,:),'-k*');
% title('Actual (diamond) and Fitted by PLS (star)');

% figure;
% plot(s,output_test(1,:),':rd',s,sybp(1,:),'-b*');
% title('Actual (diamond) and Fitted by BP (star)');
% legend('Actual','Predicated');
% figure;
% plot(s,output_test(2,:),':rd',s,sybp(2,:),'-b*');
% title('Actual (diamond) and Fitted by BP (star)');
% legend('Actual','Predicated');
% figure;
% plot(s,output_test(3,:),':rd',s,sybp(3,:),'-b*');
% title('Actual (diamond) and Fitted by BP (star)');
% legend('Actual','Predicated');
% figure;
% hold on
% plot(s,output_test(1,:),':rd',s,sybp(1,:),'-r*');
% plot(s,output_test(2,:),':bd',s,sybp(2,:),'-b*');
% plot(s,output_test(3,:),':gd',s,sybp(3,:),'-g*');
% plot(s,output_test(4,:),':cd',s,sybp(4,:),'-c*');
% plot(s,output_test(5,:),':kd',s,sybp(5,:),'-k*');
% title('Actual (diamond) and Fitted by BP (star)');
error_mat = output_test-sypcr;
mse_pcr(:,i_g) = diag(sqrt(error_mat*error_mat'));
error_mat = output_test-sypls;
mse_pls(:,i_g) = diag(sqrt(error_mat*error_mat'));
error_mat = output_test-sybp;
mse_bp(:,i_g) = diag(sqrt(error_mat*error_mat'));
end
figure;
hold on
plot([mse_pcr, mse_pls, mse_bp],'-*');
title('MSE of PCR, PLS and BP with 5 iterations of each observation');
figure;
bar(mean([mse_pcr, mse_pls, mse_bp])');
title('Average MSE of PCR, PLS and BP with 5 iterations');
% filename = 'resultdata.xlsx';
% A = {'PCR','PLS','BP';};
% sheet = 1;
% xlRange = 'A1';
% xlswrite(filename,A,sheet,xlRange)
rmpath(genpath(addr));