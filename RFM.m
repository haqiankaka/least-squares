%限定记忆最小二乘的递推算法辨识对象
%Z(k+2)=1.5*Z(k+1)-0.7*Z(k)+u(k+1)+0.5*u(k)+v(k)
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
v=randn(1,402);
%==============产生观测序列z=================
z=zeros(402,1);
z(1)=-1;
z(2)=0;
for i=3:402
z(i)=1.5*z(i-1)-0.7*z(i-2)+M(i-1)+0.5*M(i-2)+v(i);
end
%递推求解
P_a=100*eye(4);   %估计方差
Theta_a=[3;3;3;3];
L=20;	%记忆长度
for i=3:L-1     %利用最小二乘递推算法获得初步参数估计值和P阵
h=[-z(i-1);-z(i-2);M(i-1);M(i-2)];
K=P_a*h*inv(h'*P_a*h+1);
Theta_a=Theta_a+K*(z(i)-h'*Theta_a); 
P_a=(eye(4)-K*h')*P_a;
end
for k=0:380
hL=[-z(k+L-1);-z(k+L-2);M(k+L-1);M(k+L-2)];%增加新数据的信息
K_b=P_a*hL*inv(1+hL'*P_a*hL); 
Theta_b=Theta_a+K_b*(z(k+L)-hL'*Theta_a); 
P_b=(eye(4)-K_b*hL')*P_a;

hk=[-z(k+L);-z(k+L-1);M(k+L);M(k+L-1);];%去掉老数据的信息
K_a=P_b*hk*inv(1+hk'*P_b*hk); 
Theta_a=Theta_b-K_a*(z(k+L+1)-hk'*Theta_b); 
P_a=(eye(4)+K_a*hk')*P_b;
Theta_Store(:,k+1)=Theta_a;
end

%========================输出结果及作图===========================
disp('参数 a1 a2 b1 b2 的估计值为：') 
Theta_a
i=1:381;
figure(1)
plot(i,Theta_Store(1,:),i,Theta_Store(2,:),i,Theta_Store(3,:),i,Theta_Store(4,:))
title('待估参数过渡过程')
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