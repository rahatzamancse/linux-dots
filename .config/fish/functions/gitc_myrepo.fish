# Function for cloning from my git repos
# ex: gitc_myrepo 3d-reconstruction
# result: clones the repo to current dir
function gitc_myrepo
	set -l all_repos (curl -s https://api.github.com/users/rahatzamancse/repos)
	set -l repo_name (fstrcmp -s $argv (echo $all_repos | jq -r ".[].name"))
	set -l clone_url (echo $all_repos | jq -r ".[] | select(.name == \"$repo_name\") | .clone_url")
	git clone --recursive $clone_url
end
