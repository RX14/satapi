require "spec_helper"

RSpec.describe "the java classpath" do

    it "should make the commons-lang library available" do
        expect(org.apache.commons.lang.CharSetUtils).to \
            equal(Java::OrgApacheCommonsLang::CharSetUtils)
    end

    it "should make the commons-logging library available" do
        expect(org.apache.commons.logging.Log).to \
            equal(Java::OrgApacheCommonsLogging::Log)
    end

    it "should make the predict4java library available" do
        expect(Java::Uk.me.g4dpz.satellite.TLE).to \
            equal(Java::UkMeG4dpzSatellite::TLE)
    end
end
