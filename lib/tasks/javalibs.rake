require "open-uri"

namespace "javalibs" do

    def get(url, outfile)
        FileUtils.mkdir_p File.dirname(outfile)

        File.open(outfile, "wb") do |file|
            open(url, "rb") do |web|
                file.write(web.read)
            end
        end
    end

    def mvn(id, prefix)
        parts = id.split(":").first 3
        parts[0].gsub!(".", "/")

        name = "#{parts[1]}-#{parts[2]}.jar"
        repo = "http://central.maven.org/maven2"
        url = "#{repo}/#{parts[0]}/#{parts[1]}/#{parts[2]}/#{name}"
        out = "#{prefix}/#{name}"

        puts "Downloading: #{url} to #{out}"
        get url, out
    end

    file "lib/commons-lang-2.6.jar" do
        mvn "commons-lang:commons-lang:2.6", "lib"
    end

    file "lib/commons-logging-1.1.1.jar" do
        mvn "commons-logging:commons-logging:1.1.1", "lib"
    end

    file "lib/predict4java-1.1.jar" do
        mvn "uk.me.g4dpz:predict4java:1.1", "lib"
    end

    task all: ["lib/commons-lang-2.6.jar",
               "lib/commons-logging-1.1.1.jar",
               "lib/predict4java-1.1.jar"]
end

task javalibs: "javalibs:all"
