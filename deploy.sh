git checkout develop

nix-build
./result/bin/blog rebuild

git add -A
git commit -m "rebuilt site."

echo "_site/ develop:"
ls _site/

git checkout master

echo "master: "
ls 

rm -Rf ./* 

echo "master after cleaning up:"
ls -a

git checkout develop --  _site/

echo "_site/ master:"
ls _site/

git mv -f _site/* .

rmdir _site/

git add -A

git commit -m "Publish."

git push origin master

git checkout develop
