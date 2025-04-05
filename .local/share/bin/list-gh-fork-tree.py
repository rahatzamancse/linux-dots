#!/usr/bin/env python3

# Check required dependencies
def check_dependencies():
    missing_deps = []
    try:
        import requests
    except ImportError:
        missing_deps.append("requests")
    try:
        from rich.console import Console
        from rich.tree import Tree 
        from rich.text import Text
        from rich import print as rprint
    except ImportError:
        missing_deps.append("rich")
    try:
        from tqdm import tqdm
    except ImportError:
        missing_deps.append("tqdm")
    
    if missing_deps:
        print("Missing required dependencies. Please install:")
        for dep in missing_deps:
            print(f"  pip install {dep}")
        exit(1)

check_dependencies()

import requests
import time
import subprocess
import argparse
from datetime import datetime, timezone
from urllib.parse import urlparse
from tqdm import tqdm
from rich.console import Console
from rich.tree import Tree
from rich.text import Text
from rich import print as rprint

def get_github_token():
    try:
        return subprocess.check_output(['bw', 'get', 'password', 'github_token_rahat']).decode().strip()
    except (subprocess.CalledProcessError, FileNotFoundError):
        return None

def parse_github_url(url):
    """Parse GitHub URL to extract owner and repo."""
    if not url.startswith(('http://', 'https://')):
        url = 'https://' + url
    
    parsed = urlparse(url)
    if not parsed.netloc.endswith('github.com'):
        return None, None
    
    path_parts = parsed.path.strip('/').split('/')
    if len(path_parts) < 2:
        return None, None
    
    return path_parts[0], path_parts[1]

def setup_argparse():
    parser = argparse.ArgumentParser(
        description='Display a tree of GitHub repository forks with clickable links',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog='''
Examples:
  %(prog)s SteamDeckHomebrew decky-plugin-template
  %(prog)s https://github.com/SteamDeckHomebrew/decky-plugin-template
  %(prog)s --token YOUR_GITHUB_TOKEN octocat Hello-World
''')
    parser.add_argument('input', help='GitHub repository URL or owner/repo combination')
    parser.add_argument('--token', help='GitHub personal access token (optional if using Bitwarden)')
    return parser

GITHUB_TOKEN = subprocess.check_output(['bw', 'get', 'password', 'github_token_rahat']).decode().strip()
HEADERS = {'Authorization': f'token {GITHUB_TOKEN}'}
API_URL = 'https://api.github.com'

def get_last_commit_time(owner, repo):
    commits_url = f'{API_URL}/repos/{owner}/{repo}/commits?per_page=1'
    response = requests.get(commits_url, headers=HEADERS)
    if response.status_code != 200:
        return None
    
    commit_data = response.json()
    if not commit_data:
        return None
    
    commit_date = commit_data[0]['commit']['committer']['date']
    return datetime.fromisoformat(commit_date.replace('Z', '+00:00'))

def get_forks(owner, repo, depth=0, visited=None, pbar=None):
    if visited is None:
        visited = set()
        # Create progress bar for the first call
        pbar = tqdm(desc="Fetching repositories", unit=" repo")

    full_name = f"{owner}/{repo}"
    if full_name in visited:
        return {}  # Return empty dict instead of {full_name: {}}
    visited.add(full_name)
    pbar.update(1)

    forks_url = f'{API_URL}/repos/{owner}/{repo}/forks?per_page=100'
    forks = []
    page = 1
    while True:
        response = requests.get(forks_url + f"&page={page}", headers=HEADERS)
        if response.status_code != 200:
            print(f"Failed to fetch forks for {owner}/{repo}: {response.status_code}")
            break
        data = response.json()
        if not data:
            break
        forks.extend(data)
        page += 1
        time.sleep(0.5)  # Rate limit safety

    # Get commit times for all forks
    fork_data = []
    for fork in forks:
        fork_owner = fork['owner']['login']
        fork_repo = fork['name']
        last_commit = get_last_commit_time(fork_owner, fork_repo)
        fork_data.append((fork_owner, fork_repo, last_commit))
        time.sleep(0.5)  # Rate limit safety

    # Sort forks by commit time
    fork_data.sort(key=lambda x: x[2] if x[2] else datetime.min, reverse=True)
    
    # Calculate color thresholds
    total_forks = len(fork_data)
    recent_threshold = int(total_forks * 0.2)
    old_threshold = total_forks - recent_threshold

    fork_tree = {}
    for i, (fork_owner, fork_repo, last_commit) in enumerate(fork_data):
        days_ago = (datetime.now(timezone.utc) - last_commit).days if last_commit else "unknown"
        color = "green" if i < recent_threshold else "red" if i >= old_threshold else None
        fork_tree[f"{fork_owner}/{fork_repo}"] = {
            'children': get_forks(fork_owner, fork_repo, depth + 1, visited, pbar),
            'days_ago': days_ago,
            'color': color
        }

    if depth == 0:  # Close progress bar when we're done
        pbar.close()
    return {full_name: fork_tree} if depth == 0 else fork_tree

def print_tree(tree, console=None):
    if console is None:
        console = Console()
    
    def build_tree(node, parent_tree):
        for repo, data in node.items():
            children = data.get('children', {})
            days_ago = data.get('days_ago', 'unknown')
            color = data.get('color')
            
            text = f"[link=https://github.com/{repo}]{repo}[/link] [dim]({days_ago} days ago)[/dim]"
            if color:
                text = f"[{color}]{text}[/{color}]"
            
            branch = parent_tree.add(text)
            if children:
                build_tree(children, branch)
    
    root_repo = next(iter(tree))
    root_tree = Tree(f"[link=https://github.com/{root_repo}]{root_repo}[/link]")
    build_tree(tree[root_repo], root_tree)
    console.print(root_tree)

def main():
    parser = setup_argparse()
    args = parser.parse_args()
    
    # Parse input to get owner and repo
    owner, repo = parse_github_url(args.input)
    if owner is None or repo is None:
        # Try parsing as owner/repo
        parts = args.input.split('/')
        if len(parts) == 2:
            owner, repo = parts
        else:
            print("Error: Invalid input. Please provide either a GitHub URL or owner/repo combination.")
            return
    
    # Get GitHub token
    github_token = args.token or get_github_token()
    if not github_token:
        print("Error: GitHub token not found. Please provide one using --token or set up Bitwarden with 'github_token_rahat' item.")
        return
    
    global GITHUB_TOKEN, HEADERS
    GITHUB_TOKEN = github_token
    HEADERS = {'Authorization': f'token {GITHUB_TOKEN}'}
    
    tree = get_forks(owner, repo)
    print_tree(tree)

if __name__ == '__main__':
    main()

