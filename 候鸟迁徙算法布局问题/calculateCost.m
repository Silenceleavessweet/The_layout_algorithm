% 计算当前解决方案的cost
function Z_zhong = calculateCost(affinity, Juli, permutation)

V=4;%最大强度
Deviceprice=load('单位成本.txt');
zonghexiangguandu=load('综合相关度.txt');
Q=affinity;
Lo=379;    %边界长379宽高190  间距3
Wo=190;
    %第二个函数
  [NP,L]=size(permutation);
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
w1=0.5;w2=0.5;%同一数量级达到统一
Z_zhong=w1*Z1+w2*Z2;           %最终函数值
end 
