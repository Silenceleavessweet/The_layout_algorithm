%% NO.1  ���㹦�����������  Լ������ �������½�

function [Juli,X,Y] = qukuaijili(A)


Devicesize=[99.85 135.38 36.32 203.91 50.93 37.50 25.58 21.72 ;
    107.35 70.07 33.04 109.66 45.6 52.00 33.23 27.62 ];
Lo=379;    %�߽糤379���190  ���3
Wo=190;

[NP, L] = size(A);
for m=1:NP
    X(m,A(m,1))=7;   %�豸�ĳ�ʼ������ A����豸���+Devicesize(1,A(m,1))/2
end
% ��һ��
for j=1:NP
    for i=1:L
        X(j,A(j,i+1))=X(j,A(j,i))+3+Devicesize(1,A(j,i));%��һ���豸�ĺ�����
        Y(j,A(j,i))=7;  %�豸��������+Devicesize(2,A(j,i))/2
        if  X(j,A(j,i))+7+Devicesize(1,A(j,i))>Lo;%�����곬��Lo
            J(j,1)=i; %�ҳ�����Ԫ��
            break
        end
    end
    % �ڶ���
    NS=Devicesize;
    %�ж����λ����ȷ��y
    b=find(X(j,A(j,1:J(j,1)-1))<3+7+Devicesize(1,A(j,J(j,1))));%ȷ���ڶ���J(j,1)�±ߵĹ������߶ȣ��ҳ����ҽ����������
    bweizhi=b;
    I(j,1)=max(NS(2,A(j,bweizhi)));%��һ��y���
    X(j,A(j,J(j,1)))=7;%�ڶ��е�һ��������+Devicesize(1,A(j,J(j,1)))/2
    if isempty(I(j,1))
        Y(j,A(j,J(j,1)))=7+3+NS(2,A(j,1));%Devicesize(2,A(j,t+1))/2+��������������
    else
        Y(j,A(j,J(j,1)))=7+I(j,1)+3;%�ڶ��е�һ��������+Devicesize(2,A(j,J(j,1)))/2
    end
%     if  Y(j,A(j,J(j,1)))+7+Devicesize(2,A(j,J(j,1)))>Wo;%�����곬��Wo
%         Y(j,A(j,J(j,1)))=Wo;
%     end

    %�ڶ��еڶ���
    for t=J(j,1):L-1
        X(j,A(j,t+1))=X(j,A(j,t))+Devicesize(1,A(j,t))+3;%+Devicesize(1,A(j,t+1))/2
        %         if 3+ X(j,A(j,t+1))+Devicesize(1,A(j,t+1))<=X(j,A(j,bweizhi(end)))+Devicesize(1,A(j,bweizhi(end)))+3%s�϶��ҡ���bweizhi(end)��
        %             Y(j,A(j,t+1))=7+Devicesize(2,A(j,bweizhi(end)))+3;
        %         elseif X(j,A(j,bweizhi(end)))+Devicesize(1,A(j,bweizhi(end)))+3< X(j,A(j,t))+Devicesize(1,A(j,t))+3 %ɾ�������¡���
        %             Y(j,A(j,t+1))=7;
        if X(j,A(j,bweizhi(end)))+Devicesize(1,A(j,bweizhi(end)))+3< X(j,A(j,t))+Devicesize(1,A(j,t))+3 %ɾ�������¡���
            Y(j,A(j,t+1))=7;
            %��ʱ����֪�������������
%         elseif X(j,A(j,bweizhi(end)))+Devicesize(1,A(j,bweizhi(end)))+3==X(j,A(j,t))+Devicesize(1,A(j,t))+3
%             b=find(X(j,A(j,(bweizhi(end)+1):J(j,1)-1))<3+ X(j,A(j,t+1))+Devicesize(1,A(j,t+1)));%���ص�һ�е�λ��
%             bweizhi1=(bweizhi(end)+1):J(j,1)-1;
%             bweizhi=b;
%             Imax=max(NS(2,A(j,bweizhi1(bweizhi))));%��һ��y���
%             aaaaaaaaaaa=7+Imax+3;
%            
%              Y(j,A(j,t+1))=aaaaaaaaaaa;
%             bweizhi=bweizhi1(bweizhi);
            
        else
            b=find(X(j,A(j,bweizhi(end):J(j,1)-1))<3+ X(j,A(j,t+1))+Devicesize(1,A(j,t+1)));%���ص�һ�е�λ��
            bweizhi1=bweizhi(end):J(j,1)-1;
            bweizhi=b;
            Imax=max(NS(2,A(j,bweizhi1(bweizhi))));%��һ��y���
            Y(j,A(j,t+1))=7+Imax+3;%Devicesize(2,A(j,t+1))/2+
            bweizhi=bweizhi1(bweizhi);
        end
%         if  Y(j,A(j,t+1))+7+Devicesize(2,A(j,t+1))>Wo;%�����곬��Wo
%             Y(j,A(j,t+1))=Wo;
%         end
        
    end
end

for s=1:NP
    for p=1:L
        for q=1:L
            Juli(p,q,s)=abs(X(s,p)-X(s,q))+abs(Y(s,p)-Y(s,q));%x�е�p����q����������
        end
    end
end