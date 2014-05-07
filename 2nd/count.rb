#!/usr/bin/env ruby
@src = 'src.txt'
@dst = 'count.md'
chunks = open(@src).read.split(/\n\n+/).map(&:lines).map do |lines|
  lines.map do |line|
    line.gsub(/^(・|[１-３]．)/, '').chomp
  end
end

@data = {}
chunks.group_by(&:first).each do |key, vals|
  @data[key] = vals.map do |c|
    c.drop(1)
  end.flatten
end

open(@dst, 'w') do |io|
  @data.each do |key, vals|
    io << "## #{key}\n"
    vals.uniq.map do |val|
      [vals.count(val), val]
    end.sort_by do |count, val|
      [-count, val]
    end.each do |count, val|
      io << "#{count} #{val}  \n"
    end
    io << "\n"
  end
end
