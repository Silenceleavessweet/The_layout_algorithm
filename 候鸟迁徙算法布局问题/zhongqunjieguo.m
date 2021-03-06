%% NO.1  计算功能区函数结果  约束条件 坐标左下角

function [Z_zhong,X,Y] = zhongqunjieguo(A)
global  Devicesize Wo Lo Q zonghexiangguandu Deviceprice V L NP;

[NP, L] = size(A);
for m=1:NP
    X(m,A(m,1))=7;   %设备的初始横坐标 A随机设备编号+Devicesize(1,A(m,1))/2
end
% 第一行
for j=1:NP
    for i=1:L
        X(j,A(j,i+1))=X(j,A(j,i))+3+Devicesize(1,A(j,i));%下一个设备的横坐标
        Y(j,A(j,i))=7;  %设备的纵坐标+Devicesize(2,A(j,i))/2
        if  X(j,A(j,i))+7+Devicesize(1,A(j,i))>Lo;%横坐标超出Lo
            J(j,1)=i; %找出超出元素
            break
        end
    end
    % 第二行
    NS=Devicesize;
    %判断相对位置来确定y
    b=find(X(j,A(j,1:J(j,1)-1))<3+7+Devicesize(1,A(j,J(j,1))));%确定第二行J(j,1)下边的功能区高度，找出上右界大于下坐标
    bweizhi=b;
    I(j,1)=max(NS(2,A(j,bweizhi)));%第一行y最大
    X(j,A(j,J(j,1)))=7;%第二行第一个横坐标+Devicesize(1,A(j,J(j,1)))/2
    if isempty(I(j,1))
        Y(j,A(j,J(j,1)))=7+3+NS(2,A(j,1));%Devicesize(2,A(j,t+1))/2+？？？？？？？
    else
        Y(j,A(j,J(j,1)))=7+I(j,1)+3;%第二行第一个纵坐标+Devicesize(2,A(j,J(j,1)))/2
    end
%     if  Y(j,A(j,J(j,1)))+7+Devicesize(2,A(j,J(j,1)))>Wo;%纵坐标超出Wo
%         Y(j,A(j,J(j,1)))=Wo;
%     end

    %第二行第二个
    for t=J(j,1):L-1
        X(j,A(j,t+1))=X(j,A(j,t))+Devicesize(1,A(j,t))+3;%+Devicesize(1,A(j,t+1))/2
        %         if 3+ X(j,A(j,t+1))+Devicesize(1,A(j,t+1))<=X(j,A(j,bweizhi(end)))+Devicesize(1,A(j,bweizhi(end)))+3%s上二右《下bweizhi(end)右
        %             Y(j,A(j,t+1))=7+Devicesize(2,A(j,bweizhi(end)))+3;
        %         elseif X(j,A(j,bweizhi(end)))+Devicesize(1,A(j,bweizhi(end)))+3< X(j,A(j,t))+Devicesize(1,A(j,t))+3 %删除等于下《上
        %             Y(j,A(j,t+1))=7;
        if X(j,A(j,bweizhi(end)))+Devicesize(1,A(j,bweizhi(end)))+3< X(j,A(j,t))+Devicesize(1,A(j,t))+3 %删除等于下《上
            Y(j,A(j,t+1))=7;
            %暂时还不知道哪里出了问题
%         elseif X(j,A(j,bweizhi(end)))+Devicesize(1,A(j,bweizhi(end)))+3==X(j,A(j,t))+Devicesize(1,A(j,t))+3
%             b=find(X(j,A(j,(bweizhi(end)+1):J(j,1)-1))<3+ X(j,A(j,t+1))+Devicesize(1,A(j,t+1)));%返回第一行的位置
%             bweizhi1=(bweizhi(end)+1):J(j,1)-1;
%             bweizhi=b;
%             Imax=max(NS(2,A(j,bweizhi1(bweizhi))));%第一行y最大
%             aaaaaaaaaaa=7+Imax+3;
%            
%              Y(j,A(j,t+1))=aaaaaaaaaaa;
%             bweizhi=bweizhi1(bweizhi);
            
        else
            b=find(X(j,A(j,bweizhi(end):J(j,1)-1))<3+ X(j,A(j,t+1))+Devicesize(1,A(j,t+1)));%返回第一行的位置
            bweizhi1=bweizhi(end):J(j,1)-1;
            bweizhi=b;
            Imax=max(NS(2,A(j,bweizhi1(bweizhi))));%第一行y最大
            Y(j,A(j,t+1))=7+Imax+3;%Devicesize(2,A(j,t+1))/2+
            bweizhi=bweizhi1(bweizhi);
        end
%         if  Y(j,A(j,t+1))+7+Devicesize(2,A(j,t+1))>Wo;%纵坐标超出Wo
%             Y(j,A(j,t+1))=Wo;
%         end
        
    end
end

for s=1:NP
    for p=1:L
        for q=1:L
            Juli(p,q,s)=abs(X(s,p)-X(s,q))+abs(Y(s,p)-Y(s,q));%x中第p到第q功能区距离
        end
    end
end
%第二个函数
dmax=Lo+Wo;
bij=zeros(L,L,NP);
for s=1:NP
    for i=1:L
        for j=1:L
            if  Juli(i,j,s)<=dmax/6
                bij(i,j,s)=1;
            elseif dmax/6<=Juli(i,j,s) &&Juli(i,j,s)<=dmax/3
                bij(i,j,s)=0.8;
            elseif dmax/3<=Juli(i,j,s)&& Juli(i,j,s)<=dmax/2
                bij(i,j,s)=0.6;
            elseif dmax/2<=Juli(i,j,s) &&Juli(i,j,s)<=2*dmax/3
                bij(i,j,s)=0.4;
            elseif 2*dmax/3<=Juli(i,j,s)&& Juli(i,j,s)<=5*dmax/6
                bij(i,j,s)=0.2;
            else
                bij(i,j,s)=0;
            end
        end
    end
end
%     分配权重w1w2
F1=zeros(L,L);
F2=zeros(L,L);

for a=1:NP
    F1=Q.*Deviceprice.*Juli(:,:,a);%　　８＊８矩阵
    F2=V-zonghexiangguandu.*bij(:,:,a);
    
    min_Z1=min(min(F1));
    max_Z1=max(max(F1));
    max_Z2=max(max(F2));
    min_Z2=min(min(F2));
    Z11=(F1-min_Z1)/(max_Z1-min_Z1);  %统一量纲
    Z22=(F2-min_Z2)/(max_Z2-min_Z2);
    
    Z1(a,1)=sum(sum(Z11));
    Z2(a,1)=sum(sum(Z22)); %目标函数
    
end
%     w1=1/min_Z1;
%     w2=1/min_Z2;
w1=0.5;w2=0.05;%同一数量级达到统一
Z_zhong=w1*Z1+w2*Z2;           %最终函数值
end