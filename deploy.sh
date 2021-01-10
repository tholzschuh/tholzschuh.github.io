git checkout develop

nix-build
./result/bin/blog build

git add -A
git commit -m "rebuilt site."

git checkout master

rm -Rf ./ 

git checkout develop -- _site/

git mv -f _site/* .

rmdir _site/

git add -A

git commit -m "Publish."

git push origin master

git checkout develop
