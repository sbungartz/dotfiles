tag: terminal
-

as root: "sudo "
make directory: "mkdir "
change mode: "chmod "
change owner: "chown "

bundle: "bundle "
gem: "gem "
npm: "npm "
npm run deaf: "npm run dev"
yarn: "yarn "
web pack deaf: "bin/webpack-dev-server"
rails: "bin/rails "
rails server: "bin/rails s"
rails delayed job: "bin/rails jobs:work"
rails clockwork: "bundle exec clockwork config/clock.rb"
rails console: "bin/rails c"
rails migrate: "bin/rails db:migrate"
rails tests: "bin/rspec "
ruby police: "rubocop"
ruby police fix: "rubocop -a"

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

time log token:
  insert(" export NOKO_TOKEN=''")
  key("left")
time log export today: ".dotfiles/scripts/hamster-to-noko"
