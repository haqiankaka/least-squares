theta=[3;3;3;3;3;3];
p=10*eye(6);

for t=3:N                                                                          
    h=([-yk(t-1);-yk(t-2);uk(t-1);uk(t-2);y1(t-1);y1(t-2)]);
    x=1+h'*p*h;
    p=(p-p*h*1/x*h'*p);
    theta=theta+p*h*(yk(t)-h'*theta);
    
    a1t(t)=theta(1);
    a2t(t)=theta(2);
    b1t(t)=theta(3);
    b2t(t)=theta(4);
    d1t(t)=theta(5);
    d2t(t)=theta(6);
    
end
theta 
t=1:N;                              %绘制参数变化曲线
figure(4);


text(300,-1.5,'a1'); 
text(300,0.7,'a2'); 
text(300,1,'b1');
text(300,0.5,'b2');
% text(300,-1,'d1');
% text(300,0.2,'d2');

x=get(gca,'xlim');
A1=-1.5;
A2=0.7;
B1=1;
B2=0.5;
% D1=-1;
% D2=0.2;
hold on
plot(x,[A1 A1])
plot(x,[A2 A2])
plot(x,[B1 B1])
plot(x,[B2 B2])
% plot(x,[D1 D1])
% plot(x,[D2 D2])
%t ,d1t(t),t,-1,t,d2t(t),t,0.2
 plot(t,a1t(t),t,-1.5,t,a2t(t),t,0.7,t,b1t(t),t,1,t,b2t(t),t,0.5);
title('参数变化曲线');
