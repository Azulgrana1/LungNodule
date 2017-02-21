STAGE = {'train','val'};
for s = 1:2
stage = char(STAGE(s));
MAT_DIR = ['./', stage, '/'];
IMG_DIR = ['./', stage, '_image/'];
files = dir(MAT_DIR);
N = size(files, 1)-2;
listfile = fopen([IMG_DIR, 'val_image.txt'], 'w');
for i = 1:N
    filename = sprintf([stage, '_%d'], i);
    load([MAT_DIR, filename, '.mat']);
    imwrite(flatten(cand.VOL), [IMG_DIR, filename, '.jpg']);
    fprintf(listfile, [filename, '.jpg %d\n'], cand.LABEL);
end
fclose(listfile);
end