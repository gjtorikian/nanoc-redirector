require 'bundler/setup'
require 'nanoc'
require_relative '../lib/nanoc-redirector'
require 'minitest/autorun'
require 'minitest/pride'

FIXTURES_DIR = File.join(Dir.pwd, 'test', 'fixtures')
STANDARD_CONFIG = YAML.load_file(File.join(FIXTURES_DIR, 'standard_nanoc.yaml'))

class Minitest::Test
  FileUtils.rm_rf File.join(FIXTURES_DIR, 'output')
  FileUtils.rm_rf File.join(FIXTURES_DIR, 'somewhere')
  FileUtils.rm_rf File.join(FIXTURES_DIR, 'tmp')
end

def test_output_file(*dir)
  File.exist?(File.join('output', dir, 'index.html'))
end

def test_somewhere_file(*dir)
  File.exist?(File.join('somewhere', dir, 'index.html'))
end

def read_output_file(*dir)
  File.read(File.join('output', *dir, 'index.html')).gsub(/^\s*$/, '')
end

def read_somewhere_file(*dir)
  File.read(File.join('somewhere', *dir, 'index.html')).gsub(/^\s*$/, '')
end

def read_test_file(dir, name)
  File.read(File.join(FIXTURES_DIR, 'content', dir, "#{name}.html")).gsub(/^\s*$/, '')
end

def with_site(params = {})
  # Build site name
  site_name = params[:name]
  if site_name.nil?
    @site_num ||= 0
    site_name = "site-#{@site_num}"
    @site_num += 1
  end

  output_dir = params[:output_dir] || 'output'
  index_filenames = params[:index_filenames] || ['index.html']

  # Create site
  FileUtils.mkdir_p(site_name)
  FileUtils.cd(site_name) do
    FileUtils.mkdir_p('content')
    FileUtils.mkdir_p('layouts')
    FileUtils.mkdir_p('lib')
    FileUtils.mkdir_p(output_dir)

    if params[:has_layout]
      File.open('layouts/default.html', 'w') do |io|
        io.write('... <%= @yield %> ...')
      end
    end

    config = STANDARD_CONFIG
    config['output_dir'] = output_dir
    config['index_filenames'] = index_filenames
    File.open('nanoc.yaml', 'w') do |io|
      io.write config.to_yaml
    end
  end

  # Yield site
  FileUtils.cd(site_name) do
    yield Nanoc::Core::SiteLoader.new.new_from_cwd
  end
end
