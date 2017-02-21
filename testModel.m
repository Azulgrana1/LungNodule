DATA_DIR = './train_data/'; %Change data directory here
model = './ResNet-50-deploy.prototxt';
weights = './Res50_train_iter_20000.caffemodel';
caffe.set_mode_gpu();
caffe.set_device(0);

net = caffe.Net(model, weights, 'test');
mean_data = caffe.io.read_mean('./ResNet_mean.binaryproto');
load('./train_ground_truth.mat.mat');
N_all = size(ground_truth, 1);

prediction = zeros(N_all, 2);
prediction(:, 1) = (1:N_all)';

scan_folder = dir(DATA_DIR);

for scan = 3:size(scan_folder, 1)
    fprintf('Loading scan %d\n', scan-2);
    tic;
    load([DATA_DIR, scan_folder(scan).name,'/candidates.mat']);
    toc;    
    N = size(candidates, 2);
    fprintf('Testing data, total %d\n', N);
    tic;
    for i = 1:N
        block = candidates(i).VOL;
        image = single(flatten(block))';
        image = 255*repmat(imresize(image, [224, 224]),1,1,3)-mean_data;
        res = net.forward({image});
        prob = res{1};
        prediction(candidates(i).CANDIDATE_ID, 2) = prob(2);
    end
    toc;
end
calculate_auc(prediction, ground_truth)