#! user/bin/ruby

#====================================================================
def ProcessDir(curDir)
	puts "Current dir: #{curDir}"
	elements = Dir.entries(curDir)
	puts "Elements count: #{elements.count}"
	for e in elements
		if File.directory?(curDir + "/" + e) and e[0,1] != '.'
			puts "\n\nProcess sub dir: #{e}"
			ProcessDir(curDir + "/" + e)
		elsif File.extname(e) == ".png"
			if e.index("@2x")
				puts "Process file: #{e}"
				fileFrom = curDir + "/" + e
	            fileParts = fileFrom.split("@2x")
	   		    fileTo = fileParts[0] + fileParts[1];
				puts "convert -resize 50% #{fileFrom} #{fileTo}"
				system("convert -resize 50% '#{fileFrom}' '#{fileTo}'")
			end
		end
	end
end
#====================================================================


ProcessDir("Karizma/Resources/Graphics")