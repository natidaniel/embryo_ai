function [geometric, texture, gradient, comatrix_features] = propery_extraction(im_f, im_o)
% Use the following angles "offset":(0,45,90,135)
GLCM = graycomatrix(im_f,'Offset',[0 1;-1 1;-1 0;-1 -1]);
stats=graycoprops(GLCM,{'Contrast','Homogeneity','Correlation','Energy'});
contrast=(stats.Contrast);
en=(stats.Energy);
co=(stats.Correlation);
hom=(stats.Homogeneity);
m=mean(mean(im_f));
s=std2((im_f));
comatrix_features.mean = m;
comatrix_features.std = s;
comatrix_features.Homogeneity = mean(hom);
comatrix_features.Correlation = mean(co);
comatrix_features.Energy = mean(en);
comatrix_features.Contrast = mean(contrast);
f1=[m s hom co en contrast];
bw = im_o < 255;


geometric.area=sum(sum(bw));
geometric.peri=sum(sum(bw));
geometric.compact=geometric.peri^2/geometric.area;
count=1;
imh=0;
for i=1:size(bw,1)
      for j=1:size(bw,2)
          if bw(i,j)
              imh(count,1)=double(im_f(i,j));
              count=count+1;
          end
      end
end
nh=imh/geometric.area;
texture.mean=mean(imh);
texture.globalmean=texture.mean/mean(mean(double(im_f)));
texture.std=std(imh);
texture.smoothness=1/(1+texture.std^2);
texture.smoothness2 = 1- length(unique(imh))/length(imh);
texture.uniformity=sum(nh.^2);
texture.entropy=sum(nh.*log10(nh));
texture.skewness=skewness(imh);
texture.correlation=sum(nh'*imh)-texture.mean/texture.std;
x1=[];
y1=[];
z1=[];
[gradI3, Gdir] = imgradient(im_f,'sobel');
gradJ3=medfilt2(gradI3);
gradJ2=uint8(255 * mat2gray(gradJ3));
gradJ3=edge(gradJ2,'log');
gradbw=bwareaopen(gradJ2,250);
gradbwp=edge(gradbw,'sobel');
count=1;
for i=1:size(gradbw,1);
      for j=1:size(gradbw,2);
          if gradbw(i,j)
              gradimh(count,1)=double(gradI3(i,j)); 
              count=count+1;
          end
      end
  end
gradimh(gradimh==0)=[];
gradnh=gradimh/geometric.area;
gradient.mean=mean(gradimh);
gradient.std=std(gradimh);
gradient.globalmean=texture.mean/mean(mean(double(gradI3)));
gradient.uniformity=sum(gradnh.^2);
gradient.entropy=sum(gradnh.*log10(gradnh));
gradient.skewness=skewness(gradimh);
gradient.correlation=sum(gradnh'*gradimh)-gradient.mean/gradient.std;
xy=[geometric.area,geometric.peri,geometric.compact];
x1=[x1;xy];
yy=[texture.mean,texture.globalmean,texture.std,texture.smoothness, texture.smoothness2,texture.uniformity,...
    texture.entropy,texture.skewness,texture.correlation];
y1=[y1;yy];
zy=[gradient.mean,gradient.globalmean,gradient.std,s,gradient.uniformity,...
    gradient.entropy,gradient.skewness,gradient.correlation];zy=[gradient.mean,gradient.globalmean,gradient.std,s,gradient.uniformity,...
    gradient.entropy,gradient.skewness,gradient.correlation];
z1=[z1;zy];
f2=[x1 y1 z1];