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
h=[-yk(i-1);-yk(i-2);uk(i-1);uk(i-2)];
hstar=[-yk(i-2-1);-yk(i-2-2);uk(i-1);uk(i-2)];	%辅助变量
 %递推算法
K=P*hstar*inv(h'*P*hstar+1);
Theta(:,i)=Theta(:,i-1)+K*(yk(i)-h'*Theta(:,i-1)); 
P=(eye(4)-K*h')*P;
end

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
