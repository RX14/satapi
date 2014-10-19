require "open-uri"

namespace "deps"

    def get(url, path)
        File.open(path, "wb") do |file|
            open(url, "rb") do |web|
                file.write(web.read)
            end
        end
    end

    def mvn(id)

        parts = id.split(":").first 3

        parts[0].gsub!(".", "/")

        get "http://central.maven.org/maven2/#{parts[0]}/#{parts[1]}/#{parts[2]}/#{parts[1]}-#{parts[2]}.jar",
            "lib/#{parts[1]}-#{parts[2]}.jar"
    end


    file "lib/commons-lang-2.6.jar" do
        mvn "commons-lang:commons-lang:2.6"
    end

    file "lib/commons-logging-1.1.1.jar" do
        mvn "commons-logging:commons-logging:1.1.1"
    end

    file "lib/predict4java-1.1.jar" do
        get "http://jenkins.g4dpz.me.uk/job/predict4java/112/uk.me.g4dpz$predict4java/artifact/uk.me.g4dpz/predict4java/1.1/predict4java-1.1.jar",
            "lib/predict4java-1.1.jar"
    end
end
