% 初始化鸟群
function flock = createInitialFlock(nob, affinity, initialFlockSortedAccToPerf)
    % 创建每只鸟
    for i = 1: nob
        flock(i) = newSoultion(affinity);
    end
    % 如果值为2，则按cost排序
    if eq(initialFlockSortedAccToPerf, 2)  %判断两个数是否相等
        [~, index] = sort([flock.cost]);
        flock = flock(index(:));
    end
end