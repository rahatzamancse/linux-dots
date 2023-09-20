function merge_videos --description 'merge all mp4 videos in current directory to output.mp4'
	# find . -iname '*.mp4' | sed 's:\ :\\\ :g'| sed 's/^/file /' > fl.txt; ffmpeg -f concat -i fl.txt -c copy output.mp4; rm fl.txt
	for f in (find . -maxdepth 1 -iname "*.mp4" -print | string replace -r "./" "")
		echo file \'$f\' >> list.txt
	end
	ffmpeg -f concat -safe 0 -i list.txt -c copy output.mp4
	rm -f list.txt
end
