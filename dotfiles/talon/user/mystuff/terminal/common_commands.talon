tag: terminal
-

as root: "sudo "
make directory: "mkdir "
change mode: "chmod "
change owner: "chown "

code here: "code ."
nautilus here: "nautilus ."

bundle: "bundle "
bundle exec: "bundle exec "
bundle update: "bundle update "
gem: "gem "
gem install: "gem install "

npm: "npm "
npm run deaf: "npm run dev"
yarn: "yarn "
web pack deaf: "bin/webpack-dev-server"

vita: "vite "
vita run: "vite run "
vita deaf: "bin/vite dev"

foreman: "foreman "
foreman start: "foreman start "
foreman deaf: "foreman start -f Procfile.development"

rails: "bin/rails "
rails server: "bin/rails s"
rails delayed job: "bin/rails jobs:work"
rails clockwork: "bundle exec clockwork config/clock.rb"
rails console: "bin/rails c"
rails migrate: "bin/rails db:migrate"
rails reset: "bin/rails db:reset"
rails tests: "bin/rspec "
ruby police: "bundle exec rubocop"
ruby police fix: "bundle exec rubocop -a"

harp top: "htop"
multiplex: "tmux "
dot drop: "./dotdrop.sh "
dot drop install: "./dotdrop.sh install -f"

manual: "man "

root dock: "socker "
root dock build: "socker build "
root dock run: "socker run "
root dock execute: "socker exec "
root compose: "sop "
root compose up: "sop up"
root compose build: "sop build"

docker: "docker "
docker build: "docker build "
docker run: "docker run "
docker execute: "docker exec "
docker compose: "docker compose "
docker compose up: "docker compose up"
docker compose down: "docker compose down"
docker compose build: "docker compose build"

time log token:
  insert(" export NOKO_TOKEN=''")
  key("left")
time log export today: ".dotfiles/scripts/hamster-to-noko"
