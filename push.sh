message=$1

# 更新 master
git add .
git commit -m "$message"
git push -f https://github.com/eupho666/leetcode-note-ufo.git master

# 更新 gh-pages
cd docs/
git init
git add -A
git commit -m "$message"
git push -f https://github.com/eupho666/eupho666.github.io.git master