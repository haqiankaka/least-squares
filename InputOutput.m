N=400;
uk=rand(1,N);  
for i=1:N                            %�����������
    uk(i)=uk(i)*(-1)^(i-1);               
end
figure(2);
plot(uk);
title('�����������');

yk=zeros(1,N);
for k=3:N                           %�������
    yk(k)=1.5*yk(k-1)-0.7*yk(k-2)+uk(k-1)*sin(uk(k-1))+0.5*uk(k-2)
    +y1(k); 
end
