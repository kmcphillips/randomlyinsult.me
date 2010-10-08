require 'spec/rake/spectask'

task :default => :test
task :test => :spec

if !defined?(Spec)
  puts "spec targets require RSpec"
else
  desc "Run all examples"
  Spec::Rake::SpecTask.new('spec') do |t|
    t.spec_files = FileList['spec/**/*.rb']
    t.spec_opts = ['-cfs']
  end
end

namespace :db do
  desc 'Auto-migrate the database (destroys data)'
  task :migrate => :environment do
    DataMapper.auto_migrate!
  end

  desc 'Auto-upgrade the database (preserves data)'
  task :upgrade => :environment do
    DataMapper.auto_upgrade!
  end
end

namespace :gems do
  desc 'Install required gems'
  task :install do
    required_gems = %w{ sinatra rspec rack-test data_mapper dm-sqlite-adapter haml }
    required_gems.each { |required_gem| system "sudo gem install #{required_gem}" }
  end
end

task :environment do
  require 'environment'
end

task :sitemap => :environment do
  count = 0

  sitemap = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\">
   <url>
      <loc>http://randomlyinsult.me/</loc>
      <lastmod>#{Time.now.strftime("%Y-%m-%d")}</lastmod>
      <changefreq>always</changefreq>
      <priority>0.8</priority>
   </url>\n"
  
  Insult::PREFIXES.each_with_index do |obj, index_pre|
    Insult::POSTFIXES.each_with_index do |obj, index_post|
      sitemap << "    <url>
       <loc>http://randomlyinsult.me/#{index_pre}/#{index_post}</loc>
       <lastmod>#{Time.now.strftime("%Y-%m-%d")}</lastmod>
       <changefreq>always</changefreq>
    </url>\n"
      count += 1
    end
  end
  
  sitemap << "\n</urlset>"
  
  File.open('public/sitemap.xml', 'w') do |f|
    f.write(sitemap)
  end
  
  puts "Generated successfully with #{count} total combinations"
end
