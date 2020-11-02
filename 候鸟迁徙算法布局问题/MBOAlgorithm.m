clear;clc;close all;
%%
tic;
affinity=load('������.txt');
Devicesize=[99.85 135.38 36.32 203.91 50.93 37.50 25.58 21.72 ;
    107.35 70.07 33.04 109.66 45.6 52.00 33.23 27.62 ];

nob = 51; % of birds, n, ��Ⱥ����
non = 3; % of neighbors, k, �����ٶȣ���Ӧ���ʣ�̽�����ھ��� k>=2x+1
olf = 1; % overlap factor, x, WTS���ص�����
noi = 60000%nob.^3; % ��������132651
nof = 10; % of flapping (kanat cirpma), m, �����������湦��
initialFlockSortedAccToPerf=2; % 2 ��ʾ�Գ�ʼ��Ⱥ�������
% while 2 means sorting them according to their performance
NON = 0;
leaderExchangeMode =2; % 1 means exchange the leader with the successor
                        % 2 means exchanging the leader with the best
                        % 3 means exchanging if its performance is gets worse
leftSide = true;
sortAccToPerf=1; % 1 means the flock permutation stays the same
                 % 2 means sorting them according performance
                 

 % ����֮����Ҫ��������� �� ����֮��ľ���
flock = createInitialFlock(nob, affinity, initialFlockSortedAccToPerf); % 51��Ⱥ��ʼ����Ⱥ
% 					1
% 				2		3
% 			4				5
% 		6						7
jishu=0;
%%
while NON < noi   % ������Ⱥ
    for i = 1:nof   %һ�θ���103NON����ÿ�ζ��ڸ��¸���-ѭ��endλ���ǲ��������⣿������
        [NON, flock, leaderImproves] = flyFlock(nob, non, olf, NON, flock);
    end
    % �滻�����
    [flock, leftSide] = replaceLeader(nob, flock, leaderImproves, leaderExchangeMode, leftSide);
    % ����Ѱ�����Ž�
    flock = sortTheSuccessors(nob, flock, sortAccToPerf);
    leaderImproves = true;
    jishu=jishu+1;
   trace(jishu)=flock(1).cost;
end
% ������
writeResults(flock,trace);