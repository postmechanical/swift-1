#!/usr/bin/env ruby

# This works around an issue with Swift PM cloning all
# transitive dependencies into any sub-project

# See: https://github.com/danger/swift/issues/125

package = File.read("Package.swift")
new_package = package.lines.map do |line| 
  if line.include?("// dev") && line[0] == "/" 
    line[2..-1]
  else
    line
  end
end

File.write("Package.swift", new_package.join())

`git add Package.swift`
`git commit -m "Brings back the dev dependencies"`
