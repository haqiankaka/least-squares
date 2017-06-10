%广义最小二乘的递推算法仿真模型
%Z(k+2)=1.5*Z(k+1)-0.7*Z(k)+u(k+1)+0.5*u(k)+e(k)
%e(k+2)+2.1*e(k+1)-2.5*e(k)=v(k+2)
%========================================
clear 
clc
%==========400 个产生M序列作为输入===============
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
e=[]; e(1)=v(1); e(2)=v(2);
for i=3:400
e(i)=0*e(i-1)+0*e(i-2)+v(i);
end
%==============产生观测序列z=================
z=zeros(400,1);
z(1)=-1;
z(2)=0;
for i=3:400
z(i)=1.5*z(i-1)-0.7*z(i-2)+M(i-1)+0.5*M(i-2)+e(i);
end
%变换后的观测序列
zf=[];
zf(1)=-1;
zf(2)=0;
for i=3:400
    zf(i)=z(i)-0*z(i-1)-0*z(i-2);
end
%变换后的输入序列
uf=[]; uf(1)=M(1); uf(2)=M(2); 
for i=3:400
uf(i)=M(i)-0*M(i-1)-0*M(i-2);
end
%赋初值
P=100*eye(4);	%估计方差
Theta=zeros(4,400);  %参数的估计值，存放中间过程估值 
Theta(:,2)=[3;3;3;3];
K=[10;10;10;10];  %增益 
PE=10*eye(2); 
ThetaE=zeros(2,400); 
ThetaE(:,2)=[0.5;0.3];
KE=[10;10];
%递推Theta
for i=3:400
h=[-zf(i-1);-zf(i-2);uf(i-1);uf(i-2)]; 
K=P*h*inv(h'*P*h+1);
Theta(:,i)=Theta(:,i-1)+K*(z(i)-h'*Theta(:,i-1)); 
P=(eye(4)-K*h')*P;
end
he=[-e(i-1);-e(i-2)];
%递推ThetaE
KE=PE*he*inv(1+he'*PE*he);
ThetaE(:,i)=ThetaE(:,i-1)+KE*(e(i)-he'*ThetaE(:,i-1)); 
PE=(eye(2)-KE*he')*PE;
%=====================输出结果及作图=========================
disp('参数a1 a2 b1 b2的估计结果：')
Theta(:,400)
disp('噪声传递系数c1 c2的估计结果：') 
ThetaE(:,400)
i=1:400;

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
figure(1) 
plot(i,Theta(1,:),i,Theta(2,:),i,Theta(3,:),i,Theta(4,:)) 
title('待估参数过渡过程')

