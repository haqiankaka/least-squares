P=10*eye(4);   %���Ʒ���
Theta=zeros(4,401);  %�����Ĺ���ֵ������м���̹�ֵ 
Theta(:,1)=[0.001;0.001;0.001;0.001];
K=zeros(4,400);	%�������
K=[10;10;10;10];
u=0.98;   %��������
for i=3:N
h=[-yk(i-1);-yk(i-2);uk(i-1);uk(i-2)];
K=P*h*inv(h'*P*h+u);
Theta(:,i-1)=Theta(:,i-2)+K*(yk(i)-h'*Theta(:,i-2));
P=(eye(4)-K*h')*P/u;
end
%==========================����������ͼ=============================
disp('����a1 a2 b1  b2�Ĺ���ֵ:')
Theta(:,401)
i=1:401;
figure(1)
plot(i,Theta(1,:),i,Theta(2,:),i,Theta(3,:),i,Theta(4,:))
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