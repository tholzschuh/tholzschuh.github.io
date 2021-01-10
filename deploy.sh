git checkout develop

nix-build
./result/bin/site build

git checkout master

cp -a _site/. .

git add -A

git commit -m "Publish."

git push origin master

git checkout develop
