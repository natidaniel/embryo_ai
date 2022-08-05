%%
%clc;clear;close all;
%%
tic
% path_train='C:\Nati\Embryos\Debug\';
% path_out='C:\Nati\Embryos\Debug3\Debug3CPU\';

% path_train='C:\Nati\Embryos\labeled\8cell\';
% path_out='C:\Nati\Embryos\labeled3D\8cell\';

% path_train='C:\Nati\Embryos\labeled\Morula\';
% path_out='C:\Nati\Embryos\labeled3D\Morula\';
% 
% path_train='C:\Nati\Embryos\labeled\EarlyBlastrocyst\';
% path_out='C:\Nati\Embryos\labeled3D\EarlyBlastrocyst\';
% 
% path_train='C:\Nati\Embryos\labeled\LateBlastrocyst\';
% path_out='C:\Nati\Embryos\labeled3D\LateBlastrocyst\';

%path_train='C:\Nati\Embryos\cropped_06_09_18\crop_final\19_20_21\png\9v\';
%path_out='C:\Nati\Embryos\cropped_06_09_18\crop_final\19_20_21\png\9v\';
%%
d1=dir(path_train);

for ii=3:length(d1)
    I = gpuArray(imread([path_train,d1(ii).name]));
    if ndims(I) == 2 % if it's a 2D image,  Convert to 3-D.
        I1 = cat(3, I, I, I);
        I1 = gather(I1);
        imwrite(I1,[path_out,d1(ii).name]);
    end
    clear I1
end
toc