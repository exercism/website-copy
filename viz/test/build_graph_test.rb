require "minitest/autorun"
require "byebug"
require_relative "../build_graph"

class BuildGraphTest < Minitest::Test
  def test_builds_a_graph
    files_path = File.expand_path("../fixtures/**/*.tw2", __FILE__)
    output_path = File.expand_path("../tmp/graph", __FILE__)
    expected = File.read(File.expand_path("../fixtures/graph.dot", __FILE__))

    BuildGraph.(files_path, output_path)

    assert_equal expected, File.read("#{output_path}.dot")

    FileUtils.rm("#{output_path}.dot")
    FileUtils.rm("#{output_path}.png")
  end
end
