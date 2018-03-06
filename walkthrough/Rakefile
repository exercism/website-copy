require_relative "./viz/build_graph"
require "twee2"

desc "Graph the walkthrough"
task :graph do
  BuildGraph.()
end

desc "Compile the walkthrough"
task :compile do
  Twee2.build("main.tw2", "compiled.html", format: "Snowman")
end
