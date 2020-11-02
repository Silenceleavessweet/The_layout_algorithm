clear;clc;close all;
%%
tic;
affinity=load('货运量.txt');
Devicesize=[99.85 135.38 36.32 203.91 50.93 37.50 25.58 21.72 ;
    107.35 70.07 33.04 109.66 45.6 52.00 33.23 27.62 ];

nob = 51; % of birds, n, 鸟群鸟数
non = 3; % of neighbors, k, 飞行速度，感应功率，探索的邻居数 k>=2x+1
olf = 1; % overlap factor, x, WTS、重叠因子
noi = 60000%nob.^3; % 迭代次数132651
nof = 10; % of flapping (kanat cirpma), m, 襟翼数，剖面功率
initialFlockSortedAccToPerf=2; % 2 表示对初始羊群随机排序
% while 2 means sorting them according to their performance
NON = 0;
leaderExchangeMode =2; % 1 means exchange the leader with the successor
                        % 2 means exchanging the leader with the best
                        % 3 means exchanging if its performance is gets worse
leftSide = true;
sortAccToPerf=1; % 1 means the flock permutation stays the same
                 % 2 means sorting them according performance
                 

 % 工厂之间需要运输的物料 和 工厂之间的距离
flock = createInitialFlock(nob, affinity, initialFlockSortedAccToPerf); % 51种群初始化鸟群
% 					1
% 				2		3
% 			4				5
% 		6						7
jishu=0;
%%
while NON < noi   % 更新鸟群
    for i = 1:nof   %一次更新103NON——每次都在更新个体-循环end位置是不是有问题？？？？
        [NON, flock, leaderImproves] = flyFlock(nob, non, olf, NON, flock);
    end
    % 替换领飞鸟
    [flock, leftSide] = replaceLeader(nob, flock, leaderImproves, leaderExchangeMode, leftSide);
    % 排序寻找最优解
    flock = sortTheSuccessors(nob, flock, sortAccToPerf);
    leaderImproves = true;
    jishu=jishu+1;
   trace(jishu)=flock(1).cost;
end
% 输出结果
writeResults(flock,trace);