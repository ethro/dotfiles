
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
