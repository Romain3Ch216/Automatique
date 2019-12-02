function sig_db = sig_in_db(signal)
    sig_db = 20*log(signal/max(signal))/log(10);
end