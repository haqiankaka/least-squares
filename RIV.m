%Tally辅助变量最小二乘的递推算法
%Z(k+2)=1.5*Z(k+1)-0.7*Z(k)+u(k+1)+0.5*u(k)+e(k)，e(k)为有色噪声
%e(k)=v(k)+0.5*v(k-1)+0.2*v(k-2),v(k)为零均值的不相关随机噪声
%========================================
clear
clc
%==========产生M序列作为输入===============
x=[0 1 0 1 1 0 1 1 1];  %initial value
n=403; %n为脉冲数目
M=[];	%存放M 序列
for i=1:n 
    temp=xor(x(4),x(9)); 
    M(i)=x(9);
for j=9:-1:2
    x(j)=x(j-1);
end
x(1)=temp;
end
%===========产生均值为0，方差为1 的高斯白噪声=========
v=randn(1,400);
e=[];
e(1)=0.3; 
e(2)=0.5;
for i=3:400
e(i)=v(i)+0.5*v(i-1)+0.2*v(i-2);
end
%==============产生观测序列z=================
z=zeros(402,1);
z(1)=-1;
z(2)=0;
for i=3:400
z(i)=1.5*z(i-1)-0.7*z(i-2)+M(i-1)+0.5*M(i-2)+sin(M(i-1))+e(i);
end
%递推求解
P=100*eye(4);	%估计方差 
Theta=zeros(4,400);  %参数的估计值，存放中间过程估值 
Theta(:,1)=[3;3;3;3];
Theta(:,2)=[3;3;3;3]; 
Theta(:,3)=[3;3;3;3];
Theta(:,4)=[3;3;3;3];
% K=zeros(4,400);	%增益矩阵 
K=[10;10;10;10];
for i=5:400
h=[-z(i-1);-z(i-2);M(i-1);M(i-2)];
hstar=[-z(i-2-1);-z(i-2-2);M(i-1);M(i-2)];	%辅助变量
 %递推算法
K=P*hstar*inv(h'*P*hstar+1);
Theta(:,i)=Theta(:,i-1)+K*(z(i)-h'*Theta(:,i-1)); 
P=(eye(4)-K*h')*P;
end
%==================结果输出及作图===================
disp('参数a1 a2 b1 b2的估计结果：') 
Theta(:,400)
i=1:400;
figure(1) 
plot(i,Theta(1,:),i,Theta(2,:),i,Theta(3,:),i,Theta(4,:)) 

x=get(gca,'xlim');
A1=-1.5;
A2=0.7;
B1=1;
B2=0.5;
hold on
plot(x,[A1 A1])
plot(x,[A2 A2])
plot(x,[B1 B1])
plot(x,[B2 B2])
title('待估参数过渡过程')
