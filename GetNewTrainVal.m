DATA_ROOT = '../termProject/train_data/';
TRAIN_DATA = './train2_image/';
VAL_DATA = './val2_image/';

copyfile('train_positive', TRAIN_DATA);
copyfile('val_positive', VAL_DATA);

fprintf('Copying positive samples completed\n');

train_files = dir(TRAIN_DATA);
train_count = size(train_files, 1)-2;
train_list = fopen([TRAIN_DATA, 'train_image.txt'], 'a');

val_files = dir(VAL_DATA);
val_count = size(val_files, 1)-2;
val_list = fopen([VAL_DATA, 'val_image.txt'], 'a');

for scan = 1:723

CAND_DIR = sprintf('scan_%d/candidates.mat', scan);
load([DATA_ROOT, CAND_DIR]);
N = size(candidates, 2);
rand_vec = random('unif', 0, 1, N, 1);
fprintf('Scan %d, %d candidates\n', scan, N);
for i = 1:N
    cand = candidates(i);
    if(cand.LABEL == 1)
        continue;
    end
    
    if( rand_vec(i)<=0.04)
        img_name = sprintf('train_%d.jpg', train_count);
        imwrite(flatten(cand.VOL), [TRAIN_DATA, img_name]);
        fprintf(train_list, [img_name, ' %d\n'], cand.LABEL);
        train_count = train_count + 1;
    else
        if((rand_vec(i)>=1-0.02))
            img_name = sprintf('val_%d.jpg', val_count);
            imwrite(flatten(cand.VOL), [VAL_DATA, img_name]);
            fprintf(val_list, [img_name, ' %d\n'], cand.LABEL);
            val_count = val_count + 1;
        end
    end
end
end

fclose(train_list);
fclose(val_list);