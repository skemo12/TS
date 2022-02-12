function [y] = apply_filter(tf, u, fs)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    L = length(u);
    T = 1/fs;
    t = (0:L-1)*T;
    y = lsim(tf,u,t);
    return;
end

