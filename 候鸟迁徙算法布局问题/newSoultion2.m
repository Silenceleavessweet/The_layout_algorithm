% 根据邻域来构建新的解决方案
function solution = newSoultion2(affinity, conf)
    % 与之前的解决方案相同
    solution.affinity = affinity;
    % 新的排列顺序是交互随机两个位置之后的排列顺序
    solution.permutation = conf;
    % 工厂的数量
    solution.not = length(affinity);
     % 各工厂之间的距离
	[solution.distance,solution.X,solution.Y] = qukuaijili(solution.permutation);
    % 计算这种排列顺序下的cost
    solution.cost = calculateCost(solution.affinity, solution.distance, solution.permutation);

end