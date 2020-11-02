% ������
function writeResults(flock,trace)
%% ����ͼ
figure(1)
plot(trace);
title('�������ŷ������߱仯ͼ')
% legend('������Сֵ','�������ֵ','Ŀ�꺯����ֵ')
legend('������Сֵ')
xlabel('��������')  %x����������
ylabel('Ŀ�꺯���ɱ�');%y����������

%% λ��ͼ
Lo=379;    %�߽糤379���190  ���3
Wo=190;
Devicesize=[99.85 135.38 36.32 203.91 50.93 37.50 25.58 21.72 ;
    107.35 70.07 33.04 109.66 45.6 52.00 33.23 27.62 ];
figure(2)
title('���Ž������ͼ')
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
    grid on;%��ʾ����
end
clc
fprintf('���Ž��Ŀ�꺯��ֵΪ%10f\n',min(trace))

    %% ��ȡcost��С����Ⱥ
    solution = getMin(flock);
    % �������������
    fprintf('Solution Permutation:\n');
    solution.permutation
    % ���cost
    fprintf('Cost of the solution:\n');
    solution.cost
    % �������ʱ��
    toc;
end