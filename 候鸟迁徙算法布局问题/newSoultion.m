% �����µĽ������
function [solution]  = newSoultion(affinity)
    % ����֮����Ҫ���������
    solution.affinity = affinity;
    % �������������˳��
	[solution.not, solution.permutation] = createRandomConf(solution.affinity);
    % ������֮��ľ���
	[solution.distance,solution.X,solution.Y] = qukuaijili(solution.permutation);
    % ������������˳���µ�cost
    solution.cost = calculateCost(solution.affinity, solution.distance, solution.permutation);


end