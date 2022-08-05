function [out] = GLCM_Features(glcmin,pairs)
% 
% GLCM_Features helps to calculate the features from the different GLCMs
% that are input to the function. The GLCMs are stored in a i x j x n
% matrix, where n is the number of GLCMs calculated usually due to the
% different orientation and displacements used in the algorithm. Usually
% the values i and j are equal to 'NumLevels' parameter of the GLCM
% computing function graycomatrix(). 

% Takes care of 3 dimensional glcms (multiple glcms in a single 3D array)
% 
% Features computed 
% Autocorrelation: [2]                      (out.Autocorrelation)
% Contrast: matlab/[1,2]                    (out.Contrast)
% Correlation: matlab                       (out.Correlation)
% Correlation: [1,2]                        (out.Correlation2)
% Cluster Prominence: [2]                   (out.ClusterProminence)
% Cluster Shade: [2]                        (out.ClusterShade)
% Dissimilarity: [2]                        (out.Dissimilarity)
% Energy: matlab / [1,2]                    (out.Energy)
% Entropy: [2]                              (out.Entropy)
% Homogeneity: matlab                       (out.Homogeneity)
% Homogeneity: [2]                          (out.Homogeneity2)
% Maximum probability: [2]                  (out.MaximumProbability)
% Sum of sqaures: Variance [1]              (out.Variance)
% Smoothnees                                (out.Smoothness)
% Sum average [1]                           (out.SumAverage)
% Sum variance [1]                          (out.SumVariance)
% Sum entropy [1]                           (out.SumEntropy)
% Difference variance [1]                   (out.DifferenceVariance)
% Difference entropy [1]                    (out.DifferenceEntropy)
% Information measure of correlation1 [1]   (out.InformationMeasureOfCorrelation1)
% Informaiton measure of correlation2 [1]   (out.InformationMeasureOfCorrelation2)
% Inverse difference (INV) is Homogeneity [3]     (out.Homogeneity)
% Inverse difference normalized (INN) [3]   (out.InverseDifferenceNormalized) 
% Inverse difference moment normalized [3]  (out.InverseDifferenceMomentNormalized)
% 
% Where:
% u_i = u_x = sum_i( sum_j( i.p(i,j) ) ) (in paper [2])
% u_j = u_y = sum_i( sum_j( j.p(i,j) ) ) (in paper [2])
% s_i = s_x = sum_i( sum_j( (i - u_x)^2.p(i,j) ) ) (in paper [2])
% s_j = s_y = sum_i( sum_j( (j - u_y)^2.p(i,j) ) ) (in paper [2])
%
% 
% Normalize the glcm:
% Compute the sum of all the values in each glcm in the array and divide 
% each element by it sum
%
% If 'pairs' not entered: set pairs to 0 
if ((nargin > 2) || (nargin == 0))
   error('Too many or too few input arguments. Enter GLCM and pairs.');
elseif ( (nargin == 2) ) 
    if ((size(glcmin,1) <= 1) || (size(glcmin,2) <= 1))
       error('The GLCM should be a 2-D or 3-D matrix.');
    elseif ( size(glcmin,1) ~= size(glcmin,2) )
        error('Each GLCM should be square with NumLevels rows and NumLevels cols');
    end    
elseif (nargin == 1) % only GLCM is entered
    pairs = 0; % default is numbers and input 1 for percentage
    if ((size(glcmin,1) <= 1) || (size(glcmin,2) <= 1))
       error('The GLCM should be a 2-D or 3-D matrix.');
    elseif ( size(glcmin,1) ~= size(glcmin,2) )
       error('Each GLCM should be square with NumLevels rows and NumLevels cols');
    end    
end


format long e
if (pairs == 1)
    newn = 1;
    for nglcm = 1:2:size(glcmin,3)
        glcm(:,:,newn)  = glcmin(:,:,nglcm) + glcmin(:,:,nglcm+1);
        newn = newn + 1;
    end
elseif (pairs == 0)
    glcm = glcmin;
end

size_glcm_1 = size(glcm,1);
size_glcm_2 = size(glcm,2);
size_glcm_3 = size(glcm,3);

% checked 
out.Autocorrelation = zeros(1,size_glcm_3); % Autocorrelation: [2] 
out.Contrast = zeros(1,size_glcm_3); % Contrast: matlab/[1,2]
out.Correlation = zeros(1,size_glcm_3); % Correlation: matlab
out.Correlation2 = zeros(1,size_glcm_3); % Correlation: [1,2]
out.ClusterProminence = zeros(1,size_glcm_3); % Cluster Prominence: [2]
out.ClusterShade = zeros(1,size_glcm_3); % Cluster Shade: [2]
out.Dissimilarity = zeros(1,size_glcm_3); % Dissimilarity: [2]
out.Energy = zeros(1,size_glcm_3); % Energy: matlab / [1,2]
out.Entropy = zeros(1,size_glcm_3); % Entropy: [2]
out.Homogeneity = zeros(1,size_glcm_3); % Homogeneity: matlab
out.Homogeneity2 = zeros(1,size_glcm_3); % Homogeneity: [2]
out.MaximumProbability = zeros(1,size_glcm_3); % Maximum probability: [2]

out.Variance = zeros(1,size_glcm_3); % Sum of sqaures: Variance [1]
out.Smoothness = zeros(1,size_glcm_3); % Smoothness
out.SumAverage = zeros(1,size_glcm_3); % Sum average [1]
out.SumVariance = zeros(1,size_glcm_3); % Sum variance [1]
out.SumEntropy = zeros(1,size_glcm_3); % Sum entropy [1]
out.DifferenceVariance = zeros(1,size_glcm_3); % Difference variance [4]
%out.dvarh2 = zeros(1,size_glcm_3); % Difference variance [1]
out.DifferenceEntropy = zeros(1,size_glcm_3); % Difference entropy [1]
out.InformationMeasureOfCorrelation1 = zeros(1,size_glcm_3); % Information measure of correlation1 [1]
out.InformationMeasureOfCorrelation2 = zeros(1,size_glcm_3); % Informaiton measure of correlation2 [1]
%out.mxcch = zeros(1,size_glcm_3);% maximal correlation coefficient [1]
%out.invdc = zeros(1,size_glcm_3);% Inverse difference (INV) is Homogeneity [3]
out.InverseDifferenceNormalized = zeros(1,size_glcm_3); % Inverse difference normalized (INN) [3]
out.InverseDifferenceMomentNormalized = zeros(1,size_glcm_3); % Inverse difference moment normalized [3]

% correlation with alternate definition of u and s
%out.corrm2 = zeros(1,size_glcm_3); % Correlation: matlab
%out.corrp2 = zeros(1,size_glcm_3); % Correlation: [1,2]

glcm_sum  = zeros(size_glcm_3,1);
glcm_mean = zeros(size_glcm_3,1);
glcm_var  = zeros(size_glcm_3,1);

% http://www.fp.ucalgary.ca/mhallbey/glcm_mean.htm confuses the range of 
% i and j used in calculating the means and standard deviations.
% As of now I am not sure if the range of i and j should be [1:Ng] or
% [0:Ng-1]. I am working on obtaining the values of mean and std that get
% the values of correlation that are provided by matlab.
u_x = zeros(size_glcm_3,1);
u_y = zeros(size_glcm_3,1);
s_x = zeros(size_glcm_3,1);
s_y = zeros(size_glcm_3,1);

% % alternate values of u and s
% u_x2 = zeros(size_glcm_3,1);
% u_y2 = zeros(size_glcm_3,1);
% s_x2 = zeros(size_glcm_3,1);
% s_y2 = zeros(size_glcm_3,1);

% checked p_x p_y p_xplusy p_xminusy
p_x = zeros(size_glcm_1,size_glcm_3); % Ng x #glcms[1]  
p_y = zeros(size_glcm_2,size_glcm_3); % Ng x #glcms[1]
p_xplusy = zeros((size_glcm_1*2 - 1),size_glcm_3); %[1]
p_xminusy = zeros((size_glcm_1),size_glcm_3); %[1]
% checked hxy hxy1 hxy2 hx hy
hxy  = zeros(size_glcm_3,1);
hxy1 = zeros(size_glcm_3,1);
hx   = zeros(size_glcm_3,1);
hy   = zeros(size_glcm_3,1);
hxy2 = zeros(size_glcm_3,1);

%Q    = zeros(size(glcm));

for k = 1:size_glcm_3 % number glcms

    glcm_sum(k) = sum(sum(glcm(:,:,k)));
    glcm(:,:,k) = glcm(:,:,k)./glcm_sum(k); % Normalize each glcm
    glcm_mean(k) = mean2(glcm(:,:,k)); % compute mean after norm
    glcm_var(k)  = (std2(glcm(:,:,k)))^2;
    
    for i = 1:size_glcm_1

        for j = 1:size_glcm_2

            out.Contrast(k) = out.Contrast(k) + (abs(i - j))^2.*glcm(i,j,k);
            out.Dissimilarity(k) = out.Dissimilarity(k) + (abs(i - j)*glcm(i,j,k));
            out.Energy(k) = out.Energy(k) + (glcm(i,j,k).^2);
            out.Entropy(k) = out.Entropy(k) - (glcm(i,j,k)*log(glcm(i,j,k) + eps));
            out.Homogeneity(k) = out.Homogeneity(k) + (glcm(i,j,k)/( 1 + abs(i-j) ));
            out.Homogeneity2(k) = out.Homogeneity2(k) + (glcm(i,j,k)/( 1 + (i - j)^2));
            % [1] explains sum of squares variance with a mean value;
            % the exact definition for mean has not been provided in 
            % the reference: I use the mean of the entire normalized glcm 
            out.Variance(k) = out.Variance(k) + glcm(i,j,k)*((i - glcm_mean(k))^2);
            out.Smoothness(k) = out.Smoothness(k) + (1/( 1 + out.Variance(k))).*glcm(i,j,k);
            
            %out.invdc(k) = out.Homogeneity(k);
            out.InverseDifferenceNormalized(k) = out.InverseDifferenceNormalized(k) + (glcm(i,j,k)/( 1 + (abs(i-j)/size_glcm_1) ));
            out.InverseDifferenceMomentNormalized(k) = out.InverseDifferenceMomentNormalized(k) + (glcm(i,j,k)/( 1 + ((i - j)/size_glcm_1)^2));
            u_x(k)          = u_x(k) + (i)*glcm(i,j,k); 
            u_y(k)          = u_y(k) + (j)*glcm(i,j,k); 
            % code requires that Nx = Ny 
            % the values of the grey levels range from 1 to (Ng) 
        end
        
    end
    out.MaximumProbability(k) = max(max(glcm(:,:,k)));
end
% glcms have been normalized
for k = 1:size_glcm_3
    
    for i = 1:size_glcm_1
        
        for j = 1:size_glcm_2
            p_x(i,k) = p_x(i,k) + glcm(i,j,k); 
            p_y(i,k) = p_y(i,k) + glcm(j,i,k); % taking i for j and j for i
            if (ismember((i + j),[2:2*size_glcm_1])) 
                p_xplusy((i+j)-1,k) = p_xplusy((i+j)-1,k) + glcm(i,j,k);
            end
            if (ismember(abs(i-j),[0:(size_glcm_1-1)])) 
                p_xminusy((abs(i-j))+1,k) = p_xminusy((abs(i-j))+1,k) +...
                    glcm(i,j,k);
            end
        end
    end
    
%     % consider u_x and u_y and s_x and s_y as means and standard deviations
%     % of p_x and p_y
%     u_x2(k) = mean(p_x(:,k));
%     u_y2(k) = mean(p_y(:,k));
%     s_x2(k) = std(p_x(:,k));
%     s_y2(k) = std(p_y(:,k));
    
end

% marginal probabilities are now available [1]
% p_xminusy has +1 in index for matlab (no 0 index)
% computing sum average, sum variance and sum entropy:
for k = 1:(size_glcm_3)
    
    for i = 1:(2*(size_glcm_1)-1)
        out.SumAverage(k) = out.SumAverage(k) + (i+1)*p_xplusy(i,k);
        % the summation for SumAverage is for i from 2 to 2*Ng hence (i+1)
        out.SumEntropy(k) = out.SumEntropy(k) - (p_xplusy(i,k)*log(p_xplusy(i,k) + eps));
    end

end
% compute sum variance with the help of sum entropy
for k = 1:(size_glcm_3)
    
    for i = 1:(2*(size_glcm_1)-1)
        out.SumVariance(k) = out.SumVariance(k) + (((i+1) - out.SumEntropy(k))^2)*p_xplusy(i,k);
        % the summation for SumAverage is for i from 2 to 2*Ng hence (i+1)
    end

end
% compute difference variance, difference entropy
for k = 1:size_glcm_3
% out.dvarh2(k) = var(p_xminusy(:,k));
    for i = 0:(size_glcm_1-1)
        out.DifferenceEntropy(k) = out.DifferenceEntropy(k) - (p_xminusy(i+1,k)*log(p_xminusy(i+1,k) + eps));
        out.DifferenceVariance(k) = out.DifferenceVariance(k) + (i^2)*p_xminusy(i+1,k);
    end
end

% compute information measure of correlation(1,2) [1]
for k = 1:size_glcm_3
    hxy(k) = out.Entropy(k);
    for i = 1:size_glcm_1
        
        for j = 1:size_glcm_2
            hxy1(k) = hxy1(k) - (glcm(i,j,k)*log(p_x(i,k)*p_y(j,k) + eps));
            hxy2(k) = hxy2(k) - (p_x(i,k)*p_y(j,k)*log(p_x(i,k)*p_y(j,k) + eps));
%             for Qind = 1:(size_glcm_1)
%                 Q(i,j,k) = Q(i,j,k) +...
%                     ( glcm(i,Qind,k)*glcm(j,Qind,k) / (p_x(i,k)*p_y(Qind,k)) ); 
%             end
        end
        hx(k) = hx(k) - (p_x(i,k)*log(p_x(i,k) + eps));
        hy(k) = hy(k) - (p_y(i,k)*log(p_y(i,k) + eps));
    end
    out.InformationMeasureOfCorrelation1(k) = ( hxy(k) - hxy1(k) ) / ( max([hx(k),hy(k)]) );
    out.InformationMeasureOfCorrelation2(k) = ( 1 - exp( -2*( hxy2(k) - hxy(k) ) ) )^0.5;
%     eig_Q(k,:)   = eig(Q(:,:,k));
%     sort_eig(k,:)= sort(eig_Q(k,:),'descend');
%     out.mxcch(k) = sort_eig(k,2)^0.5;
end

corm = zeros(size_glcm_3,1);
corp = zeros(size_glcm_3,1);

for k = 1:size_glcm_3
    for i = 1:size_glcm_1
        for j = 1:size_glcm_2
            s_x(k)  = s_x(k)  + (((i) - u_x(k))^2)*glcm(i,j,k);
            s_y(k)  = s_y(k)  + (((j) - u_y(k))^2)*glcm(i,j,k);
            corp(k) = corp(k) + ((i)*(j)*glcm(i,j,k));
            corm(k) = corm(k) + (((i) - u_x(k))*((j) - u_y(k))*glcm(i,j,k));
            out.ClusterProminence(k) = out.ClusterProminence(k) + (((i + j - u_x(k) - u_y(k))^4)*...
                glcm(i,j,k));
            out.ClusterShade(k) = out.ClusterShade(k) + (((i + j - u_x(k) - u_y(k))^3)*...
                glcm(i,j,k));
        end
    end
    s_x(k) = s_x(k) ^ 0.5;
    s_y(k) = s_y(k) ^ 0.5;
    out.Autocorrelation(k) = corp(k);
    out.Correlation2(k) = (corp(k) - u_x(k)*u_y(k))/(s_x(k)*s_y(k));
    out.Correlation(k) = corm(k) / (s_x(k)*s_y(k));
%     % alternate values of u and s
%     out.corrp2(k) = (corp(k) - u_x2(k)*u_y2(k))/(s_x2(k)*s_y2(k));
%     out.corrm2(k) = corm(k) / (s_x2(k)*s_y2(k));
end

% % Contrast 
% out.contrp = zeros(size_glcm_3,1);
% contp = 0;
% Ng = size_glcm_1;
% for k = 1:size_glcm_3
%     for n = 0:(Ng-1)
%         for i = 1:Ng
%             for j = 1:Ng
%                 if (abs(i-j) == n)
%                     contp = contp + glcm(i,j,k);
%                 end
%             end
%         end
%         out.contrp(k) = out.contrp(k) + n^2*contp;
%         contp = 0;
%     end
%     
% end

