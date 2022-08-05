% GLDM script
%
% For details on the Gray level Difference Method, refer the following paper
% J. K. Kim and H. W. Park, "Statistical textural features for
% detection of microcalcifications in digitized mammograms",
% IEEE Trans. Med. Imag. 18, 231-238 (1999).

SurvivedComparison = 'FALSE';
Survived_plusNot_Comparison = 'TRUE';

% Read Input Image
if strcmp(Survived_plusNot_Comparison,'TRUE')
    inImg_1 = rgb2gray(imread('C:\Nati\Embryos\4Yoni\Embryo Deep learning\images\O\9_8\4\1\50.png')); %s
    out_1 = CS_Image(inImg_1);
    inImg_2 = rgb2gray(imread('C:\Nati\Embryos\4Yoni\Embryo Deep learning\images\O\9_8\4\2\50.png')); %ns
    out_2 = CS_Image(inImg_2);
end
if strcmp(SurvivedComparison,'TRUE')
    inImg_1 = rgb2gray(imread('C:\Nati\Embryos\4Yoni\Embryo Deep learning\images\O\9_8\4\1\50.png')); %s
    out_1 = CS_Image(inImg_1);
    inImg_2 = rgb2gray(imread('C:\Nati\Embryos\4Yoni\Embryo Deep learning\images\O\9_8\5\1\50.png')); %s2
    out_2 = CS_Image(inImg_2);
end

% Set the intersample distance d
d = 25;
% GRAY LEVEL DIFFERENCE METHOD
[pdf1_1, pdf2_1, pdf3_1, pdf4_1] = GLDM(out_1, d);
[pdf1_2, pdf2_2, pdf3_2, pdf4_2] = GLDM(out_2, d);

% Plot
figure;
if strcmp(Survived_plusNot_Comparison,'TRUE')
    subplot(221);plot(pdf1_1);hold on; plot(pdf1_2);title('          horizontal-weighted sum');legend({'survived','not survived'},'Location','southeast');legend('boxoff');
    subplot(222);plot(pdf2_1);hold on; plot(pdf2_2);title('     vertical-weighted sum');legend({'survived','not survived'},'Location','southeast');legend('boxoff');
    subplot(223);plot(pdf3_1);hold on; plot(pdf3_2);title('        diagonal-weighted sum');legend({'survived','not survived'},'Location','southeast');legend('boxoff');
    subplot(224);plot(pdf4_1);hold on; plot(pdf4_2);title('grid-weighted sum');legend({'survived','not survived'},'Location','southeast');legend('boxoff');
end
if strcmp(SurvivedComparison,'TRUE')
    subplot(221);plot(pdf1_1);hold on; plot(pdf1_2);title('          horizontal-weighted sum');legend({'survived-1','survived-2'},'Location','southeast');legend('boxoff');
    subplot(222);plot(pdf2_1);hold on; plot(pdf2_2);title('     vertical-weighted sum');legend({'survived-1','survived-2'},'Location','southeast');legend('boxoff');
    subplot(223);plot(pdf3_1);hold on; plot(pdf3_2);title('        diagonal-weighted sum');legend({'survived-1','survived-2'},'Location','southeast');legend('boxoff');
    subplot(224);plot(pdf4_1);hold on; plot(pdf4_2);title('grid-weighted sum');legend({'survived-1','survived-2'},'Location','southeast');legend('boxoff');
end