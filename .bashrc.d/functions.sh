
cpMods()
{
   mkdir -p ../mods
   cp --parents $(git ls-files --modified --others --exclude-standard) ../mods
}
