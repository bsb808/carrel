function sxx = shin(omega)

% Example two-sided PSD from Shinozuka and Deodatis

sigma = 1;
b = 1;

sxx = 1/4 * sigma^2 * b^3 * omega.^2 .*exp(-b*abs(omega));