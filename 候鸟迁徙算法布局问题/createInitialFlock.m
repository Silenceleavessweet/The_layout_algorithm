% ��ʼ����Ⱥ
function flock = createInitialFlock(nob, affinity, initialFlockSortedAccToPerf)
    % ����ÿֻ��
    for i = 1: nob
        flock(i) = newSoultion(affinity);
    end
    % ���ֵΪ2����cost����
    if eq(initialFlockSortedAccToPerf, 2)  %�ж��������Ƿ����
        [~, index] = sort([flock.cost]);
        flock = flock(index(:));
    end
end