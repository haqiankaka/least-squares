%�޶�������С���˵ĵ����㷨��ʶ����
%Z(k+2)=1.5*Z(k+1)-0.7*Z(k)+u(k+1)+0.5*u(k)+v(k)
%========================================
clear 
clc
%==========����M������Ϊ����===============
x=[0 1 0 1 1 0 1 1 1];  %initial value 
n=403; %nΪ������Ŀ
M=[];	%���M ����
for i=1:n 
    temp=xor(x(4),x(9));
    M(i)=x(9);
for j=9:-1:2
x(j)=x(j-1);
end
x(1)=temp;
 end
%===========������ֵΪ0������Ϊ1 �ĸ�˹������=========
v=randn(1,402);
%==============�����۲�����z=================
z=zeros(402,1);
z(1)=-1;
z(2)=0;
for i=3:402
z(i)=1.5*z(i-1)-0.7*z(i-2)+M(i-1)+0.5*M(i-2)+v(i);
end
%�������
P_a=100*eye(4);   %���Ʒ���
Theta_a=[3;3;3;3];
L=20;	%���䳤��
for i=3:L-1     %������С���˵����㷨��ó�����������ֵ��P��
h=[-z(i-1);-z(i-2);M(i-1);M(i-2)];
K=P_a*h*inv(h'*P_a*h+1);
Theta_a=Theta_a+K*(z(i)-h'*Theta_a); 
P_a=(eye(4)-K*h')*P_a;
end
for k=0:380
hL=[-z(k+L-1);-z(k+L-2);M(k+L-1);M(k+L-2)];%���������ݵ���Ϣ
K_b=P_a*hL*inv(1+hL'*P_a*hL); 
Theta_b=Theta_a+K_b*(z(k+L)-hL'*Theta_a); 
P_b=(eye(4)-K_b*hL')*P_a;

hk=[-z(k+L);-z(k+L-1);M(k+L);M(k+L-1);];%ȥ�������ݵ���Ϣ
K_a=P_b*hk*inv(1+hk'*P_b*hk); 
Theta_a=Theta_b-K_a*(z(k+L+1)-hk'*Theta_b); 
P_a=(eye(4)+K_a*hk')*P_b;
Theta_Store(:,k+1)=Theta_a;
end

%========================����������ͼ===========================
disp('���� a1 a2 b1 b2 �Ĺ���ֵΪ��') 
Theta_a
i=1:381;
figure(1)
plot(i,Theta_Store(1,:),i,Theta_Store(2,:),i,Theta_Store(3,:),i,Theta_Store(4,:))
title('�����������ɹ���')
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