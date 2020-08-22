require 'test_helper'

class RedirectFromTest < MiniTest::Test
  def test_it_renders_redirect_from_string
    with_site(name: FIXTURES_DIR) do |site|
      site = Nanoc::Core::SiteLoader.new.new_from_cwd
      Nanoc::Core::Compiler.compile(site)

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
      site = Nanoc::Core::SiteLoader.new.new_from_cwd
      Nanoc::Core::Compiler.compile(site)

      output_file = read_output_file('redirect_from', 'array')
      test_file = read_test_file('redirect_from', 'array')
      assert_equal output_file, test_file

      assert test_output_file(['this-is-old'])
      output_file = read_output_file(['this-is-old'])
      assert_includes output_file, 'redirect_from/array'

      assert test_output_file(%w[articles this-is-older])
      output_file = read_output_file(%w[articles this-is-older])
      assert_includes output_file, 'redirect_from/array'
    end
  end
end
