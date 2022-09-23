function p = converg(x,xx)

xx = flip(xx);
k = length(xx);
p = vpa(log(abs(xx(k-1)-xx(k))/abs(xx(k-2)-xx(k)))/log(abs(xx(k-2)-xx(k))/abs(xx(k-3)-xx(k))),30);

end