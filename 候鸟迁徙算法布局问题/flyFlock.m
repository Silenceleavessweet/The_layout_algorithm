% ������Ⱥ   bests(i)�洢���Ž��
function [NON, flock, leaderImproves] = flyFlock(nob, non, olf, NON, flock)
    % ��ȡ�����
    leader = flock(1);
    % �������������
    [leaderNeighborSet, NON] = createNeighborSet(non, NON, leader);
    % ��������������
    for i = 2:nob
        [flock(i).neighborSet, NON] = createNeighborSet(non - olf, NON, flock(i));%ÿһ�ε���������¸���
    end
    % ȡ���������cost��С������/���Ž�
    [bests(1), leaderNeighborSet] = getBestNeighbour(leaderNeighborSet);
    %����ͷ���2-3�񹹳ɽ⼯���ҳ����Ÿ��帶��2��3����
    % ��ȡ�����֮�����ֻ�񣨱��Ϊ2��3����������֮ǰ�����ȡ�Ľ�͵�ǰ����������
    for i = 1:2 * olf
        % ��ȡ�����������ʣ��Ľ�����Ž�
        [best, leaderNeighborSet] = getBestNeighbour(leaderNeighborSet);
        % ���Ϊ����������֮ǰ������ߵ���̳� ���Ϊ2
        if eq(1, mod(i,2))
            flock(2).neighborSet = addNeighbour(best, flock(2).neighborSet);
        else
            % ���Ϊż�������Ҳ����̳� ���Ϊ3
            flock(3).neighborSet = addNeighbour(best, flock(3).neighborSet);
        end
    end
    
    % ��ȡ���������������Ž�
    for i = 2:nob - 2
        % ��ȡ��ǰ������Ž�flock(2).neighborSet��1*3����
        [bests(i), flock(i).neighborSet] = getBestNeighbour(flock(i).neighborSet);
        for j = 1:olf
            % ��֮������Ž⴫�ݸ���һֻ����һֻ��ı��Ϊi+2
            [best, flock(i).neighborSet] = getBestNeighbour(flock(i).neighborSet);
            flock(i+2).neighborSet = addNeighbour(best, flock(i+2).neighborSet);
        end
    end
    
    % ��ȡ�����ֻ����������Ž�
    [bests(nob - 1), flock(nob - 1).neighborSet] = getBestNeighbour(flock(nob - 1).neighborSet);
    [bests(nob), flock(nob).neighborSet] = getBestNeighbour(flock(nob).neighborSet);
    
    % �ж��������û�н���
    if flock(1).cost <= bests(1).cost
        leaderImproves = false;
    else
        leaderImproves = true;
    end
    
    % �����ж���Ⱥ�е�ÿֻ���Ƿ���Խ���
    for i = 1:nob
        if flock(i).cost >= bests(i).cost
            bests(i).neighborSet = [];
            flock(i) = bests(i);
        end
    end
end