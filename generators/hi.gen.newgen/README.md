#hi.gen.newgen

Generator to create generators

    hi newgen


#Publish

curl -u 'k33g' https://api.github.com/user/repos -d '{"name":"hi.gen.bb"}'

cd hi.gen.bb
git init
git add .
git commit -m "first version"
git remote add origin https://github.com/k33g/hi.gen.bb.git
git push -u origin master


update :
git commit -a
git push -u origin master