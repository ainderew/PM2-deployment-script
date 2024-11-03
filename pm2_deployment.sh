#add project path
PROJECT_DIR=""
#process name of application  in PM2
PROCESS_NAME=""
branch=$1

if [-z "$branch" ]; then
  echo "No branch specified!"
  return 1
fi

cd $PROJECT_DIR
git fetch origin $branch
git checkout $branch
git pull origin $branch
npm ci

BUILD_DIR=temp npm run build

rm -rf build
mv temp build

pm2 reload $PROCESS_NAME
