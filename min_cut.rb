require 'pry'
require 'ds'

include DS

filename = "./test.txt"
file = File.open(filename, "r")
lines = file.readlines.map(&:chomp)


edges = []

lines.each do |line|
  list = line.split(" ").map(&:to_i)
  source = list[0]

  list[1...list.length].each do |destination|
    edges << Edge.new(source, destination)
  end

end

graph = Graph.new(edges)

def min_cut(graph)
  graph_dupe = graph.dup

  while(graph_dupe.vertex_size > 2)
    binding.pry
    edge_to_remove = random_edge(graph_dupe)

    graph_dupe = merge_nodes(graph_dupe, edge_to_remove.to, edge_to_remove.from)
  end

  count = 0

  graph_dupe.each_edge{|edge| count += 1}
  count
end

def random_edge(graph)
  edges = []
  graph.each_edge{|edge| edges << edge }

  edges.sample
end

#returns a new graph with the two given nodes merged together)
def merge_nodes(graph, x, y)
  new_edges = graph.neighbors(x).inject([]) do |new_edges, neighbor|
    graph.remove(x, neighbor)
    graph.remove(neighbor, x)
    new_edges << Edge.new(neighbor, y)
  end

  graph.each_edge{|edge| new_edges << edge }

  Graph.new(new_edges)
end


binding.pry
