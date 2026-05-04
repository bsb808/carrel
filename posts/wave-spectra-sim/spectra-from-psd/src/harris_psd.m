function sxx = harris_psd(omega)

% Harris spectrum

Kw = 1.0;
% Derive time constant from cuttoff freq.
f = 1; % hz
taug = 1/(f*2*pi);

sxx = 10*Kw./(1+taug*omega);

% % White noise
% sxx = ones(size(omega));
% 
% sxx = omega;
% 
% sxx = zeros(size(omega))
% for ii = 1:length(omega)
%     if omega(ii) > f*2*pi;
%         sxx(ii) = 0.0;
%     else
%         sxx(ii) = 1.0;
%     end
% end


end
