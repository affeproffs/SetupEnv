ask() {
  echo
  echo -n "(?) $* [y/N]: "
  read -r confirm
  [ "$confirm" = "y" ] && return 0
  return 1
}

get() {
  echo
  echo -n "(?) $1: "
  read -r "$2"
}