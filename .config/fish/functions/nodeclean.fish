function nodeclean
    # Remove node_modules directories
    find . -name "node_modules" -type d -prune -exec rm -rf {} +

    # Remove common build output directories
    find . -type d \( -name "dist" -o -name "build" -o -name ".next" -o -name "out" \) -prune -exec rm -rf {} +

    # Remove lock files (optional, uncomment if desired)
    # find . -type f \( -name "package-lock.json" -o -name "yarn.lock" -o -name "pnpm-lock.yaml" \) -delete
end

