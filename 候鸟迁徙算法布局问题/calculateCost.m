% ���㵱ǰ���������cost
function Z_zhong = calculateCost(affinity, Juli, permutation)

V=4;%���ǿ��
Deviceprice=load('��λ�ɱ�.txt');
zonghexiangguandu=load('�ۺ���ض�.txt');
Q=affinity;
Lo=379;    %�߽糤379���190  ���3
Wo=190;
    %�ڶ�������
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
%     ����Ȩ��w1w2
F1=zeros(L,L);
F2=zeros(L,L);

for a=1:NP
    F1=Q.*Deviceprice.*Juli(:,:,a);%��������������
    F2=V-zonghexiangguandu.*bij(:,:,a);
    
    min_Z1=min(min(F1));
    max_Z1=max(max(F1));
    max_Z2=max(max(F2));
    min_Z2=min(min(F2));
    Z11=(F1-min_Z1)/(max_Z1-min_Z1);  %ͳһ����
    Z22=(F2-min_Z2)/(max_Z2-min_Z2);
    
    Z1(a,1)=sum(sum(Z11));
    Z2(a,1)=sum(sum(Z22)); %Ŀ�꺯��
    
end
   %     w1=1/min_Z1;
%     w2=1/min_Z2;
w1=0.5;w2=0.5;%ͬһ�������ﵽͳһ
Z_zhong=w1*Z1+w2*Z2;           %���պ���ֵ
end 
