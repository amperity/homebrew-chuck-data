class ChuckDataTest < Formula
  include Language::Python::Virtualenv

  desc "AI-powered customer data engineering assistant for Databricks (TEST VERSION from test.pypi)"
  homepage "https://github.com/amperity/chuck-data"
  version "0.4.8"
  url "https://test-files.pythonhosted.org/packages/c1/f2/40da15f8022d8fceca5639d8be61e939c53bcf780a9015d2b3e20f89f880/chuck_data-0.4.8.tar.gz"
  sha256 "c7c20bf77b488c5eea512d9b1e21e48b381568473581348bce99fd1e41c31de3"
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
