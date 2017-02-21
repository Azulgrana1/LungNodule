STAGE = {'train','val'};
for s = 1:2
stage = char(STAGE(s));
MAT_DIR = ['./', stage, '/'];
IMG_DIR = ['./', stage, '_positive/'];
files = dir(MAT_DIR);
N = size(files, 1)-2;
listfile = fopen([IMG_DIR, stage, '_image.txt'], 'w');
count = 1;
for i = 1:N
    filename = sprintf([stage, '_%d'], i);
    load([MAT_DIR, filename, '.mat']);
    if(cand.LABEL == 0)
        continue;
    end
    block = cand.VOL;
    filename = sprintf([stage, '_%d'], count);
    imwrite(flatten(block), [IMG_DIR, filename, '.jpg']);
    fprintf(listfile, [filename, '.jpg %d\n'], cand.LABEL);
    
    filename = sprintf([stage, '_%d'], count+1);
    imwrite(flatten(permute(block, [2,3,1])), [IMG_DIR, filename, '.jpg']);
    fprintf(listfile, [filename, '.jpg %d\n'], cand.LABEL);
    
    filename = sprintf([stage, '_%d'], count+2);
    imwrite(flatten(permute(block, [3,1,2])), [IMG_DIR, filename, '.jpg']);
    fprintf(listfile, [filename, '.jpg %d\n'], cand.LABEL);
    
    count = count+3;
end
fclose(listfile);
end