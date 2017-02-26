require 'English'
require 'html-proofer'
require 'rubocop/rake_task'
require 'jekyll'

task :build, [:options] do |_t, args|
  # Build twice to handle FastImage issue of non-existent images on init build
  puts 'Building site...'.yellow.bold
  args.with_defaults(options: {})
  orig_stdout = STDOUT.clone
  STDOUT.reopen('/dev/null', 'w')
  Jekyll::Commands::Build.process({})
  STDOUT.reopen(orig_stdout)
  Jekyll::Commands::Build.process(args[:options])
end

task :clean do
  puts 'Cleaning up _site...'.yellow.bold
  Jekyll::Commands::Clean.process({})
end

desc 'Test website with html_proofer'
task :html_proofer do
  puts 'Running html proofer...'.yellow.bold
  HTMLProofer.check_directory(
    '_site/',
    allow_hash_href: 'true',
    # check_html: 'true', # Removed due to fail on p end tags w/ no way to not
    check_opengraph: 'true',
    enforce_https: 'true',
    url_swap: { 'www.averyjfischer.com' => '' }, # Fixes internal links checks.
    http_status_ignore: [999], # `999 No Error` from LinkedIn
    internal_domains: ['www.averyjfischer.com', 'averyjfischer.com'],
    url_ignore:
    [
    ]
  ).run
end

desc 'Run RuboCop'
task :rubocop do
  puts 'Running RuboCop Validator...'.yellow.bold
  RuboCop::RakeTask.new
end

desc 'Run all tests'
task :test do
  Rake::Task['rubocop'].invoke
  Rake::Task['build'].invoke
  Rake::Task['html_proofer'].invoke
end
