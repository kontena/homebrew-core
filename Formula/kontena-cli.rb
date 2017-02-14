class KontenaCli < Formula
  desc "container and microservices platform command-line client"
  homepage "https://kontena.io/"
  url "https://github.com/kontena/kontena/archive/v1.1.1.tar.gz"
  sha256 "e08e26a78e678eb0a1e5a2aa687829b9473a0c4744060b48e4a35050ebad0221"
  head "https://github.com/kontena/kontena.git"

  bottle :unneeded

  depends_on :ruby => "2.4"

  def install
    gem_command = which("gem")
    ruby_command = which("ruby")

    # There's something strange in the way -g / --file works in gem install, seems to work better when you run it in the .gemspec directory.
    Dir.chdir buildpath/"cli"
    system gem_command, "install", "-g", "--no-document", "--norc", "--without", "test,development", "--install-dir=#{buildpath}/cli/lib/vendor"
    Dir.chdir buildpath


    # Point to the ruby dependency, "env ruby" can give you a different ruby otherwise
    inreplace buildpath/"cli/bin/kontena", "#!/usr/bin/env ruby", "#!#{ruby_command}"

    # Modify the GEM_PATH to load from the vendor directory
    inreplace buildpath/"cli/bin/kontena", "# add self to libpath", "# add vendor to gem path\nENV['GEM_PATH'] = '#{libexec}/vendor'\nGem.paths = ENV\n\n# add self to libpath"

    # Files in lib/ will be installed to brew's "libexec", so change the loadpath to point there
    inreplace buildpath/"cli/bin/kontena", "$:.unshift File.expand_path('../../lib', bin_file)", "$:.unshift '#{libexec}'"

    bin.install Dir["cli/bin/*"]
    libexec.install Dir["cli/lib/*"]
    prefix.install buildpath/"cli/README.md"
    prefix.install buildpath/"CHANGELOG.md"
    prefix.install buildpath/"cli/LOGO"
    prefix.install buildpath/"cli/VERSION"
    doc.install Dir["docs/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kontena --version")
  end
end
