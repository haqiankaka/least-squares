N=400;
uk=rand(1,N);  
for i=1:N                            %产生随机输入
    uk(i)=uk(i)*(-1)^(i-1);               
end
figure(2);
plot(uk);
title('随机输入曲线');

yk=zeros(1,N);
for k=3:N                           %定义输出
    yk(k)=1.5*yk(k-1)-0.7*yk(k-2)+uk(k-1)*sin(uk(k-1))+0.5*uk(k-2)
    +y1(k); 
end
