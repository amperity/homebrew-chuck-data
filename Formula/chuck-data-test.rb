class ChuckDataTest < Formula
  include Language::Python::Virtualenv

  desc "AI-powered customer data engineering assistant for Databricks (TEST VERSION from test.pypi)"
  homepage "https://github.com/amperity/chuck-data"
  version "0.4.6"
  url "https://test-files.pythonhosted.org/packages/b5/b8/51297e6c4805335896b8998fc1c3ede1d80636dc97935f81edbd3493788d/chuck_data-0.4.6.tar.gz"
  sha256 "371cd0b493ecb45370a9ae3c124bd3149c8ba139792e36c7575fd0d45841081e"
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
