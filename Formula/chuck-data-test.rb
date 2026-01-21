class ChuckDataTest < Formula
  include Language::Python::Virtualenv

  desc "AI-powered customer data engineering assistant for Databricks (TEST VERSION from test.pypi)"
  homepage "https://github.com/amperity/chuck-data"
  version "0.4.1"
  url "https://test-files.pythonhosted.org/packages/31/0d/e929b04472064581d1bbe7e2e84f1ec3ff7f5bb4de392195f6d2ffb6ce68/chuck_data-0.4.1.tar.gz"
  sha256 "fee8163f017755ce3f0d02565b06e2f348fec03a99e645bc31425c8ee31f857b"
  license "Apache-2.0"

  depends_on "python@3.12"

  def install
    virtualenv_create(libexec, "python3.12")
    virtualenv = libexec/"bin/python"
    system virtualenv, "-m", "pip", "install", "--upgrade", "pip"
    # Install from test.pypi with fallback to regular pypi for dependencies
    system virtualenv, "-m", "pip", "install", "--index-url", "https://test.pypi.org/simple/", "--extra-index-url", "https://pypi.org/simple", "chuck-data[aws]==#{version}"
    (bin/"chuck").write_env_script libexec/"bin/chuck", PYTHONPATH: libexec/Language::Python.site_packages("python3.12")
  end

  test do
    system "#{bin}/chuck", "--help"
  end
end
