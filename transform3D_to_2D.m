tic
d1=dir(path_train);
for ii=3:length(d1)
    I=imread([path_train,d1(ii).name]);
    if ndims(I) == 3 % if it's a 3D image,  Convert to 2D.
        I1  = rgb2gray(I);
        imwrite(I1,[path_out,d1(ii).name]);
    end
    clear I1
end
toc