function [X,ndx,dbg] = natsortfiles(X,rgx,varargin)
assert(iscell(X),'First input <X> must be a cell array.')
tmp = cellfun('isclass',X,'char') & cellfun('size',X,1)<2 & cellfun('ndims',X)<3;
assert(all(tmp(:)),'First input <X> must be a cell array of strings (1xN character).')
%
if nargin>1
    varargin = [{rgx},varargin];
end
%
%% Split and Sort File Names/Paths %%
%
% Split full filepaths into file [path,name,extension]:
[pth,fnm,ext] = cellfun(@fileparts,X(:),'UniformOutput',false);
% Split path into {dir,subdir,subsubdir,...}:
pth = regexp(pth,'[^/\\]+','match'); % either / or \ as filesep.
len = cellfun('length',pth);
num = max(len);
vec = cell(numel(len),1);
%
% Natural-order sort of the file extensions and filenames:
if isempty(num)
    ndx = [];
    ids = [];
    dbg = {};
elseif nargout<3 % faster:
    [~,ndx] = natsort(ext,varargin{:});
    [~,ids] = natsort(fnm(ndx),varargin{:});
else % for debugging:
    [~,ndx,dbg{num+2}] = natsort(ext,varargin{:});
    [~,ids,tmp] = natsort(fnm(ndx),varargin{:});
    [~,idd] = sort(ndx);
    dbg{num+1} = tmp(idd,:);
end
ndx = ndx(ids);
%
% Natural-order sort of the directory names:
for k = num:-1:1
    idx = len>=k;
    vec(:) = {''};
    vec(idx) = cellfun(@(c)c(k),pth(idx));
    if nargout<3 % faster:
        [~,ids] = natsort(vec(ndx),varargin{:});
    else % for debugging:
        [~,ids,tmp] = natsort(vec(ndx),varargin{:});
        [~,idd] = sort(ndx);
        dbg{k} = tmp(idd,:);
    end
    ndx = ndx(ids);
end
%
% Return the sorted array and indices:
ndx = reshape(ndx,size(X));
X = X(ndx);
%
end