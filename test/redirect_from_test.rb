require 'test_helper'

class RedirectFromTest < MiniTest::Test
  def test_it_renders_redirect_from_string
    with_site(name: FIXTURES_DIR) do |site|

      site = Nanoc::Int::SiteLoader.new.new_from_cwd
      Nanoc::Int::Compiler.compile(site)

      output_file = read_output_file('redirect_from', 'string')
      test_file = read_test_file('redirect_from', 'string')
      assert_equal output_file, test_file

      assert test_output_file(['here', 'is-a-place'])
      output_file = read_output_file(['here', 'is-a-place'])
      assert_includes output_file, 'redirect_from/string'
    end
  end

  def test_it_renders_redirect_from_array
    with_site(name: FIXTURES_DIR) do |site|

      site = Nanoc::Int::SiteLoader.new.new_from_cwd
      Nanoc::Int::Compiler.compile(site)

      output_file = read_output_file('redirect_from', 'array')
      test_file = read_test_file('redirect_from', 'array')
      assert_equal output_file, test_file

      assert test_output_file(['this-is-old'])
      output_file = read_output_file(['this-is-old'])
      assert_includes output_file, 'redirect_from/array'

      assert test_output_file(['articles', 'this-is-older'])
      output_file = read_output_file(['articles', 'this-is-older'])
      assert_includes output_file, 'redirect_from/array'
    end
  end

  def test_it_does_not_clobber_existing_files
    with_site(name: FIXTURES_DIR) do |site|
      site = Nanoc::Int::SiteLoader.new.new_from_cwd
      Nanoc::Int::Compiler.compile(site)

      output_file = read_output_file('redirect_from', 'existing-content')
      test_file = read_test_file('redirect_from', 'existing-content')
      assert_equal output_file, test_file
    end
  end

  def test_it_allows_redirects_from_content_directory_indexes
    with_site(name: FIXTURES_DIR) do |site|
      site = Nanoc::Int::SiteLoader.new.new_from_cwd
      Nanoc::Int::Compiler.compile(site)

      nested_redirect_file = read_output_file('redirect_from', 'nested')
      assert_includes nested_redirect_file, 'redirect_from/from-nested-root'
    end
  end
end
