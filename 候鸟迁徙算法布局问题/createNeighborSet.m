% ̽����ǰ �������/�� ��non������
function [neighbourSet, number] = createNeighborSet(non, NON, solution)%������ʵ��2=non
    % ����non�������
    for i = 1:non
        % ̽�����򽻲������¸���  ̽����������1
        neighbourSet(i) = neighbour(solution);
        NON = NON + 1;
    end
    % ��������������
    neighbourSet = sortNeighbours(neighbourSet);
    % ������̽����������
    number = NON;
end