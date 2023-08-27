
txt2pdf()
{
    input_file=$1
    filename="${input_file%.*}"

    enscript "$input_file" --output=- | ps2pdf - > $filename.pdf
}

gr()
{
   find -name .git -exec sh -c "cd \"\$(dirname \"{}\")\"; printf \"|----- \"; pwd; $*;" \;
}

grg()
{
   find -type d -name .git -exec sh -c "cd \"\$(dirname \"{}\")\"; printf \"|----- \"; pwd; $*;" \;
}

grs()
{
   find -type f -name .git -exec sh -c "cd \"\$(dirname \"{}\")\"; printf \"|----- \"; pwd; $*;" \;
}

#function dots {
#   git --git-dir=$HOME/.dotfiles --work-tree=$HOME $@
#}

gsls()
{
   find -type d -name .git -exec sh -c "cd \"\$(dirname \"{}\")\"; printf \"|----- \"; pwd; git status -s -b --ahead-behind" \;
}

gfls()
{
   find -type d -name .git -exec sh -c "cd \"\$(dirname \"{}\")\"; printf \"|----- \"; pwd; git fetch; git status -s -b --ahead-behind" \;
}

gat()
{
   find -type d -name .git -exec sh -c "cd \"\$(dirname \"{}\")\"; printf \"|----- \"; pwd; git tag $1; git push origin $1" \;
}

gatm()
{
   find -type d -name .git -exec sh -c "cd \"\$(dirname \"{}\")\"; printf \"|----- \"; pwd; git tag -a -m \"$2\" $1; git push origin $1" \;
}

cpMods()
{
   mkdir -p ../mods
   cp --parents $(git ls-files --modified --others --exclude-standard) ../mods
}

cpOnlyMods()
{
   mkdir -p ../onlymods
   cp --parents $(git ls-files --modified) ../onlymods
}

findDiff()
{
   fileToDiffPath=$1
   fileToDiff=$(basename "$fileToDiffPath")

   echo "$fileToDiff"

   find -type f -name "$fileToDiff" -exec vimdiff "$fileToDiffPath" "{}" \;
}

brightness()
{
   max_brightness=$(cat "/sys/class/backlight/intel_backlight/max_brightness")
   scale=$(expr $max_brightness \* $1)
   set_brightness=$(expr $scale / 100)
   echo $set_brightness > "/sys/class/backlight/intel_backlight/brightness"
}

utared()
{
    gpg -d "$1" | tar xjvf -
}

tared()
{
    local _dir_name=$(echo "$1" | sed 's:/*$::')
    echo $_dir_name
    local _GPG_TTY=$GPG_TTY
    export GPG_TTY=$(tty)
    if [ -d "$_dir_name" ]; then
        tar cjvpf - "$_dir_name" | gpg --symmetric --cipher-algo aes256 -o "$_dir_name.tar.bz2.gpg"
    else
        echo "Unable to find [$_dir_name]"
    fi
    export GPG_TTY=$_GPG_TTY
}

utarefd()
{
    local _dir_name=$(echo "$1" | cut -f1 -d".")
    mkdir -p "$_dir_name"
    gpg -d "$1" | tar xjvf - -C "$_dir_name"
}

utaref()
{
    gpg -d "$1" | tar xjvf - 
}

tarel()
{
    local _tar_name=$1
    local _GPG_TTY=$GPG_TTY
    export GPG_TTY=$(tty)
    gpg -d $_tar_name | tar -tjf -
    export GPG_TTY=$_GPG_TTY
}

taref()
{
    local _tar_name=$1
    shift
    local _args=$*
    local _GPG_TTY=$GPG_TTY
    export GPG_TTY=$(tty)
    tar cjvpf - $_args | gpg --symmetric --cipher-algo aes256 -o "$_tar_name.tar.bz2.gpg"
    export GPG_TTY=$_GPG_TTY
}

# ------------------------------------------------------------------------------
# open file from ripgrep/fzf
rvim()
{
    filepath_line="$(rg -n $2 $1 | fzf)"
    echo $filepath_line
    filepath=$(echo "$filepath_line" | cut -d":" -f1)
    line=$(echo "$filepath_line" | cut -d":" -f2)

    if ! [ "$filepath" == "" ] && ! [ "$line" == "" ]; then
        echo nvim +$line "$filepath"
        nvim +$line "$filepath"
    fi
}

pv()
{
   python3 -m venv ".venv_$1"
   source ".venv_$1/bin/activate"
}

pvr()
{
   python3 -m venv ".venv_$1"
   source ".venv_$1/bin/activate"
   pip install -r requirements.txt
}

pvp()
{
   python3 -m venv ".venv_$1"
   source ".venv_$1/bin/activate"
   pip install pyproject.toml
}

ssh_tx_pub()
{
   # Attempt to transfer the default id_rsa.pub to the hosts authorized_keys
   _PUBLIC_KEY=~/.ssh/id_rsa.pub
   _HOST_ALIAS=$1
   _HOST_USERNAME=$2
   if [ -z ${_HOST_USERNAME} ]; then
      _HOST_USERNAME=$USER
   fi
   if [ -e $_PUBLIC_KEY ]; then
      cat $_PUBLIC_KEY | ssh -e none $_HOST_USERNAME@$_HOST_ALIAS 'cat >> .ssh/authorized_keys'
   fi
}

