class ChuckData < Formula
  include Language::Python::Virtualenv

  desc "AI-powered customer data engineering assistant for Databricks"
  homepage "https://github.com/amperity/chuck-data"
  version "0.3.0"
  url "https://files.pythonhosted.org/packages/source/c/chuck-data/chuck_data-#{version}.tar.gz"
  sha256 "f6081a64c1b3e0ca874597bab877682d73fd90575c97ba21e11764fc043feffc"
  license "Apache-2.0"

  depends_on "python@3.12"

  def install
    virtualenv_create(libexec, "python3.12")
    virtualenv = libexec/"bin/python"
    system virtualenv, "-m", "pip", "install", "--upgrade", "pip"
    system virtualenv, "-m", "pip", "install", "chuck-data[aws]==#{version}"
    (bin/"chuck").write_env_script libexec/"bin/chuck", PYTHONPATH: libexec/Language::Python.site_packages("python3.12")
  end

  test do
    system "#{bin}/chuck", "--help"
  end
end
