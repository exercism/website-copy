require "graph"

class BuildGraph
  TITLE_REGEX = /^:: *([^\[]*?) *[\[(.*?)\]]? *[<(.*?)>]? *$/
  LINK_REGEX = /\[\[(.*)->(.*)\]\]/

  def self.call(*args)
    new(*args).call
  end

  def initialize(glob="**/*.tw2", output_path="graph")
    @glob = glob
    @output_path = output_path
    @graph = {}
  end

  def call
    parse_files!
    build_graph!
  end

  private
  attr_reader :output_path, :glob, :graph

  def parse_files!
    Dir[glob].
      reject{ |file| file['viz/'] }.
      each do |file|
        text = read_file!(file)
        title = parse_title!(text)
        graph[title] = parse_links!(text)
      end
  end

  def read_file!(file)
    File.read(file)
  end

  def parse_title!(text)
    text.match(TITLE_REGEX).captures[0].strip
  end

  def parse_links!(text)
    text.scan(LINK_REGEX).map do |link|
      _, dest = link

      dest
    end
  end

  def build_graph!
    graph = @graph

    digraph do
      graph.each do |src, dest|
        dest.each { |node| send(:edge, src, node) }
      end
    end.save(output_path, "png")
  end
end
