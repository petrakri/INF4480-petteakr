% function name = NameFromSignal(signal);
%
% Function that decodes a vector of 0 and 1 (the signal) to a text based
% on MATLAB® default character encoding scheme.
% The function assumes that 8-bit coding has been used

% 
% AA, 2/3-2014:   First version.

function name = NameFromSignal(signal);

% Make sure signal is a column vector
if size(signal,2) ~= 1
    signal = signal.';
end

% Reshape signal to a 8 x N matrix
signal = reshape(signal,8,[]);

% Convert integers to numbers
tmp = num2str(signal,'%d');

% Flip matrix
tmp = tmp.';

% Decode and flip final answer
name = native2unicode(bin2dec(tmp)).';


