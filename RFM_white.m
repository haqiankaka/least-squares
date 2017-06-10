theta=[0;0;0;0];
p=10^6*eye(4);
for  s=3:100;
    h=([yk(s-1);yk(s-2);uk(s-1);uk(s-2)]);
    p=p-p*h*(inv(1+h'*p*h))*h'*p;
    theta=theta+p*h*(yk(s)-h'*theta);
end

for t=3:N-100                      
    m=s+t;
    h=([yk(m-1);yk(m-2);uk(m-1);uk(m-2)]);
    p=p-p*h*(inv(1+h'*p*h))*h'*p;   
    theta=theta+p*h*(yk(m)-h'*theta);
    h=([yk(t-1);yk(t-2);uk(t-1);uk(t-2)]);
    p=p+p*h*(inv(1-h'*p*h))*h'*p;
    theta=theta+p*h*(yk(t)-h'*theta);
    
    a1t(t)=theta(1);
    a2t(t)=theta(2);
    b1t(t)=theta(3);
    b2t(t)=theta(4);
    
end

theta 
t=1:N;                              %绘制参数变化曲线
figure(4);


text(300,-1.5,'a1'); 
text(300,0.7,'a2'); 
text(300,1,'b1');
text(300,0.5,'b2');

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

plot(t,a1t(t),t,-1.5,t,a2t(t),t,0.7,t,b1t(t),t,1,t,b2t(t),t,0.5);
title('参数变化曲线');