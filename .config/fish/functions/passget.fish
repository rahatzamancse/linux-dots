function passget --description 'get password from bitwarden with fuzzy matching'
	set -l all_items (rbw list)
	for item in $all_items
		if string match -q -r "$argv" "*$item*"
			set -a matched $item
		end
	end
	if test (count $matched) -gt 1
		for i in (seq (count $matched))
			echo $i: $matched[$i]
		end
		echo ''
		read -l -P "Which one?: " ind
		echo ''
		if string match -q -r '\D' $ind ; or test $ind -le 0 ; or test $ind -gt (count $matched)
			echo "Invalid input"
			return
		end
		rbw get --field username $matched[$ind]
		echo -n "password: " && rbw get --field password $matched[$ind]
	else if test (count $matched) -le 0
		echo "No entry found"
		return
	else
		rbw get --field username $matched[1]
		echo -n "password: " && rbw get --field password $matched[1]
	end
end
