desc "compile and run the site"
task :default do
  pids = [
    spawn("jekyll serve --watch"),
    spawn("scss --watch assets/sass:css"),
    spawn("coffee -b -w -o js -c assets/coffee")
  ]
 
  trap "INT" do
    Process.kill "INT", *pids
    exit 1
  end
 
  loop do
    sleep 1
  end
end
