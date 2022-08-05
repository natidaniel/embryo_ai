c = 0; % d-counter
for i=1:length(imds.Files)
    I = gpuArray(imread(imds.Files{i,1}));
    if ndims(I) == 2 % if it's a 2D image
        % debug
        %imds.Files{i,1} % display img name
        %c = c + 1; % count how much 2D imgs types
        % Delete or convert yo 3D
        delete(imds.Files{i,1})
        %I1 = cat(3, I, I, I);
        %I1 = gather(I1);
        %imwrite(I1,imds.Files{i,1});
    end
end