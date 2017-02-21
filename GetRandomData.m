%Get balanced data
DATA_ROOT = '../termProject/train_data/';
TRAIN_DATA = './train/';
VAL_DATA = './val/';

train_count = 1;
val_count = 1;

for scan = 1:723
CAND_DIR = sprintf('scan_%d/candidates.mat', scan);
load([DATA_ROOT, CAND_DIR]);
N = size(candidates, 2);
rand_vec = random('unif', 0, 1, N, 1);

for i = 1:N
    cand = candidates(i);
    if( (cand.LABEL == 1 && rand_vec(i)<=0.7 ) || (cand.LABEL == 0 && rand_vec(i)<=0.03))
            filename = sprintf('train_%d.mat', train_count);            
            save([TRAIN_DATA, filename], 'cand');
            train_count = train_count + 1;
    else if((cand.LABEL == 1 && rand_vec(i)>0.7 ) || (cand.LABEL == 0 && rand_vec(i)>=1-0.015))
            filename = sprintf('val_%d.mat', val_count);
            save([VAL_DATA, filename], 'cand');
            val_count = val_count + 1;
        end
    end
end
end
