            s = tf('s');
            w = 12;
            z = 0.2;
            H = w^2 / (s^2 + 2*w*z*s + w^2);
            t = [0:0.1:10];         % Use this time vector
            u = [t <= 3] - [t > 3]; % Use this as input
            % TODO
            err = 0.1;
            y = lsim(H, u, t);
            n = length(t);
            t_stationary = 0;
            for i = 1 : n
                if ( t(i) > 3 ) 
                    if ( y(i) < err )
                        t_stationary = t(i);
                        return;
                    end
                end
            end