{ pkgs, user, ... }:

{
    programs.tmux = {
        enable = true;
        clock24 = true;
        extraConfig = ''
            set -sg escape-time 0

            set-option -g default-command "cd $PWD"
            set -g mouse on

            unbind c-b
            set -g prefix C-x

            bind -n M-0 select-window -t0
            bind -n M-1 select-window -t1
            bind -n M-2 select-window -t2
            bind -n M-3 select-window -t3
            bind -n M-4 select-window -t4
            bind -n M-5 select-window -t5
            bind -n M-6 select-window -t6
            bind -n M-7 select-window -t7
            bind -n M-8 select-window -t8
            bind -n M-9 select-window -t9

            bind -n M-f resize-pane -Z
            bind -n M-h select-pane -L
            bind -n M-j select-pane -D
            bind -n M-k select-pane -U
            bind -n M-l select-pane -R
        '';
    };
}
