require 'redirect-to-filter'
require 'version'

module NanocRedirector
  module RedirectFrom
    def self.process(item, dest)
      return if item[:redirect_from].nil?
      return if dest.nil?
      redirect_hash = {}

      key = item.identifier.without_ext
      value = item[:redirect_from].is_a?(String) ? [item[:redirect_from]] : item[:redirect_from]

      redirect_hash[key] = value

      redirect_hash.values.each do |redirects|
        redirects.each do |redirect|
          content = NanocRedirector.redirect_template(dest)
          dir = "output/#{redirect}"
          FileUtils.mkdir_p(dir) unless File.directory?(dir)
          File.write("#{dir}/index.html", content) unless File.exist? "#{dir}/index.html"
        end
      end
    end
  end

  def self.redirect_template(item_url)
    <<-EOF
<!DOCTYPE html>
<html>
<head>
<meta charset=utf-8>
<title>Redirecting...</title>
<link rel=canonical href="#{item_url}">
<meta http-equiv=refresh content="0; url=#{item_url}">
<h1>Redirecting...</h1>
<a href="#{item_url}">Click here if you are not redirected.</a>
<script>location='#{item_url}'</script>
</body>
</html>
EOF
  end
end
