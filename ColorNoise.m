y1=randn(1,2500);               %������˹������
y1=y1/std(y1);
y1=y1-mean(y1);
a=0;
b=sqrt(0.1);
y1=a+b*y1;
figure(1);
plot(y1);


for i=1:2500                          %������ɫ����
    y1(i)=1;
end
plot(y1);
title('��ɫ����');