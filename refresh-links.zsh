#!/usr/bin/zsh
# Refresh the symlinks to the configuration files in this directory.
# Assuming the links need to be placed in the home directory.

exit_status=0

function make_link() {
    echo "Executing: ln -sr $*"
    ln -sr $*
}

for cfg_file in ${0:h}/*; do
    if [[ ! ($0 -ef $cfg_file) ]] ; then
        cfg_link="${HOME}/.${cfg_file:t}"
        if [[ -e $cfg_link  && -L $cfg_link ]] ; then
            cfg_lnk_target="$(readlink ${cfg_link})"
            # If the link target is relative, make it absolute
            if [[ $cfg_lnk_target != /* ]] ; then
                cfg_lnk_target="${HOME}/${cfg_lnk_target}"
            fi
            if [[ ! ($cfg_file -ef $cfg_lnk_target) ]] ; then
                echo "Warning: Link ${cfg_link} points" \
                    "to an unexpected location (${cfg_lnk_target})."
                rm -i $cfg_link
                if [[ -e $cfg_link ]] ; then
                    echo "Error: Unable to update link ${cfg_link}."
                    exit_status=1
                else
                    make_link $cfg_file $cfg_link
                fi
            fi
        elif [[ -e $cfg_link ]] ; then
            echo "Error: File ${cfg_link} exists and is not a symlink!"
            echo "Please move or rename it and run this script again."
            exit_status=2
        else
            make_link $cfg_file $cfg_link
        fi
    fi
done

exit $exit_status

