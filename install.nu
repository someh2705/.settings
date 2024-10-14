run-external "git" "add" "."

run-external "sudo" "nixos-rebuild" "switch" "--flake" "."