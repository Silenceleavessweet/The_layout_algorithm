% ���������������µĽ������
function solution = newSoultion2(affinity, conf)
    % ��֮ǰ�Ľ��������ͬ
    solution.affinity = affinity;
    % �µ�����˳���ǽ����������λ��֮�������˳��
    solution.permutation = conf;
    % ����������
    solution.not = length(affinity);
     % ������֮��ľ���
	[solution.distance,solution.X,solution.Y] = qukuaijili(solution.permutation);
    % ������������˳���µ�cost
    solution.cost = calculateCost(solution.affinity, solution.distance, solution.permutation);

end