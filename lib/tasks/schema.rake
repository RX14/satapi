require "prmd/rake_tasks/combine"
require "prmd/rake_tasks/verify"
require "prmd/rake_tasks/doc"

repo_root = File.absolute_path("#{__dir__}/../../")

namespace :schema do
    Prmd::RakeTasks::Combine.new do |t|
        t.options[:meta] = "#{repo_root}/docs/schema/meta.json"
        t.paths << "#{repo_root}/docs/schema/schemata"
        t.output_file = "#{repo_root}/docs/schema/api.json"
    end

    Prmd::RakeTasks::Verify.new do |t|
        t.files << "#{repo_root}/docs/schema/api.json"
    end

    Prmd::RakeTasks::Doc.new do |t|
        t.files = { "#{repo_root}/docs/schema/api.json" => "#{repo_root}/docs/schema/api.md" }
    end
end

task schema: ["schema:combine", "schema:verify", "schema:doc"]
