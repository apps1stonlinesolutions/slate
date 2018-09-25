git add --all
read -p 'Commit message: ' uservar
git commit -m uservar
git push
./deploy.sh
