% 输出结果
function writeResults(flock,trace)
%% 折线图
figure(1)
plot(trace);
title('迭代最优方案曲线变化图')
% legend('函数最小值','函数最大值','目标函数均值')
legend('函数最小值')
xlabel('迭代次数')  %x轴坐标描述
ylabel('目标函数成本');%y轴坐标描述

%% 位置图
Lo=379;    %边界长379宽高190  间距3
Wo=190;
Devicesize=[99.85 135.38 36.32 203.91 50.93 37.50 25.58 21.72 ;
    107.35 70.07 33.04 109.66 45.6 52.00 33.23 27.62 ];
figure(2)
title('最优结果布局图')
rectangle('position',[0,0,Lo,Wo]);
xlabel('X') ;
ylabel('Y') ;
for b=1:length(Devicesize)
    h=Devicesize(2,b);
    w=Devicesize(1,b);
    x1=flock(1).X(1,b);
    y1=flock(1).Y(1,b);
    x=x1+w/2;
    y=y1+h/2;
    rectangle('Position',[x1,y1,w,h]) ;
    text(x-3,y,num2str(b));
    hold on;
    grid on;%显示网格
end
clc
fprintf('最优解的目标函数值为%10f\n',min(trace))

    %% 获取cost最小的鸟群
    solution = getMin(flock);
    % 输出工厂的排列
    fprintf('Solution Permutation:\n');
    solution.permutation
    % 输出cost
    fprintf('Cost of the solution:\n');
    solution.cost
    % 输出运行时间
    toc;
end