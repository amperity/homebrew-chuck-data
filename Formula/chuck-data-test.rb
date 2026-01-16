class ChuckDataTest < Formula
  include Language::Python::Virtualenv

  desc "AI-powered customer data engineering assistant for Databricks (TEST VERSION from test.pypi)"
  homepage "https://github.com/amperity/chuck-data"
  version "0.4.0"
  url "https://test-files.pythonhosted.org/packages/65/4a/96f048f1b386d1316ded777f13cd4a83ccaa9b266f5f321226fe04754af2/chuck_data-0.4.0.tar.gz"
  sha256 "ae5248c8e163c573067f15ca601465a122ac5a848c620b641eac4f3415d87e42"
  license "Apache-2.0"

  depends_on "python@3.12"

  def install
    virtualenv_create(libexec, "python3.12")
    virtualenv = libexec/"bin/python"
    system virtualenv, "-m", "pip", "install", "--upgrade", "pip"
    # Install from test.pypi with fallback to regular pypi for dependencies
    system virtualenv, "-m", "pip", "install", "--index-url", "https://test.pypi.org/simple/", "chuck-data[aws]==#{version}"
    (bin/"chuck").write_env_script libexec/"bin/chuck", PYTHONPATH: libexec/Language::Python.site_packages("python3.12")
  end

  test do
    system "#{bin}/chuck", "--help"
  end
end
