# Diff pacnews with meld
function pacnewsdiff
    sudo meld $argv[1] $argv[1].pacnew
    if read_confirm 'Do you want to delete the pacnew?'
        sudo rm $argv[1].pacnew
    end
end
