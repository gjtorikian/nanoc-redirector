# Nanoc-Redirector

This plugin implements client-side redirects _from_ and _to_ other generated pages. It's pretty close in functionality to Jekyll's [redirect-from](https://github.com/jekyll/jekyll-redirect-from) plugin.

Redirects are performed by serving an HTML file with an HTTP-REFRESH meta
tag which points to your destination. No `.htaccess` file, nginx conf, xml
file, or anything else will be generated. It simply creates HTML files.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nanoc-redirector'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nanoc-redirector

## Usage

The object of this gem is to allow an author to specify multiple URLs for a
page, such that the alternative URLs redirect to the new URL.

To use it, simply add a string or array to the YAML front-matter of your page:

### Redirect From

``` yaml
title: My amazing post
redirect_from:
  - /post/123456789/
  - /post/123456789/my-amazing-post/
```

For example, this frontmatter will generate two pages in the following destinations:

```
/post/123456789/
/post/123456789/my-amazing-post/
```

Each will point to wherever `My amazing post` is routed to.

You can also specify just one url like this:

```text
title: My other awesome post
redirect_from: /post/123456798/
```

You can implement this functionality by calling `NanocRedirector::RedirectFrom.process` anywhere in your Rules file. You must pass in the item to redirect to, as well as its destination. For example:

``` ruby
require 'nanoc-redirector'

postprocess do
  @items.each do |item|
    NanocRedirector::RedirectFrom.process(item, item.path)
  end
end
```

### Redirect To filter

Sometimes, you may want to redirect a site page to a totally different website. This plugin also supports that with the `redirect_to` key:

``` yaml
title: My amazing post
redirect_to:
  - http://www.github.com
```

If you have multiple `redirect_to`s set, only the first one will be respected.

You can implement this functionality by adding a filter to your compile step:

``` ruby
compile '/**/*.md' do
  filter :redirect_to, { :redirect_to => @item[:redirect_to] }
  layout '/default.*'
end
```
