function comb=allcomb(ip)

ncells=length(ip);
[nd{1:ncells}]=ndgrid(ip{:});
catted=cat(ncells,nd{1:ncells});
comb=reshape(catted,length(catted(:))/ncells,ncells);