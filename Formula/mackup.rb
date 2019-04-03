class Mackup < Formula
  include Language::Python::Virtualenv

  desc "Keep your Mac's application settings in sync"
  homepage "https://github.com/lra/mackup"
  url "https://github.com/lra/mackup/archive/0.8.23.tar.gz"
  sha256 "40dbe6e645c67ef91d094a8d2c74bd5c0d1c15931061503c57e4a8216ba50d14"
  head "https://github.com/lra/mackup.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "f408737ea932cddbd32341b31e4e806c8db5cd9a204f886a3ee5b15e206ec320" => :mojave
    sha256 "d5b88ec07319aeda343260197a5707d4e41d3314892036b2c90086b924aba2ee" => :high_sierra
    sha256 "72172ff10f99725fbce8cfbb3bea5db8aaf82b10fe32d145548b3a281235cff2" => :sierra
  end

  depends_on "python"

  resource "docopt" do
    url "https://files.pythonhosted.org/packages/a2/55/8f8cab2afd404cf578136ef2cc5dfb50baa1761b68c9da1fb1e4eed343c9/docopt-0.6.2.tar.gz"
    sha256 "49b3a825280bd66b3aa83585ef59c4a8c82f2c8a522dbe754a8bc8d08c85c491"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/16/d8/bc6316cf98419719bd59c91742194c111b6f2e85abac88e496adefaf7afe/six-1.11.0.tar.gz"
    sha256 "70e8a77beed4562e7f14fe23a786b54f6296e34344c23bc42f07b15018ff98e9"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    system "#{bin}/mackup", "--help"
  end
end
