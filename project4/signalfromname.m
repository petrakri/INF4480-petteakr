% function signal = SignalFromName(name,N);
%
% Function that repeats a name (text variabel) N times and
% returns the binary representation of the string where 8 and 8 bits
% represents a character coded with e MATLAB� default character encoding
% scheme.

% 
% AA, 2/3-2014:   First version.

function signal = signalfromname(name,N)

if nargin < 2
    N = 1;
end

% For some funny reason, check to see that all characters can be coded 
% using 7 bits.  

if any(unicode2native(name) > 127)
    error('Please only use characters from the English alphabet')
end

% code a N-fold repetititon of the string as 0 and 1, return it as
% a vector of integers:
tmp = dec2bin(unicode2native(repmat(name,[1,N])),8).';


signal = str2num(tmp(:));

