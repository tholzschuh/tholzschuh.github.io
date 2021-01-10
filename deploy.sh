git checkout develop

nix-build
./result/bin/site build

git add -A
git commit -m "rebuilt site."

git checkout master

git checkout develop -- _site/

git mv -f _site/* .

git rmdir _site/

git add -A

git commit -m "Publish."

git push origin master

git checkout develop
