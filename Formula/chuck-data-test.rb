class ChuckDataTest < Formula
  include Language::Python::Virtualenv

  desc "AI-powered customer data engineering assistant for Databricks (TEST VERSION from test.pypi)"
  homepage "https://github.com/amperity/chuck-data"
  version "0.4.3"
  url "https://test-files.pythonhosted.org/packages/b8/b6/0c7cca55fd7c9db414211fffac55a27e1b3538e08c63b8b00874fd7790a2/chuck_data-0.4.3.tar.gz"
  sha256 "6c9cc8f99e50ec0fd92a0ba685434d18224e85163f7aacbae49a0d5b885d70d5"
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
