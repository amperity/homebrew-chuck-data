class ChuckData < Formula
  include Language::Python::Virtualenv

  desc "AI-powered customer data engineering assistant for Databricks"
  homepage "https://github.com/amperity/chuck-data"
  url "https://files.pythonhosted.org/packages/f8/45/62bbfec660130c4b802bf65a879a1e637ef67364bcc39f2e619d1a55dafb/chuck_data-0.1.2.tar.gz"
  sha256 "bcf32f0afc5aac30b6bc8245133c8b83e34df228290f4e48e02d6d1f256df13b"
  license "Apache-2.0"

  depends_on "python@3.12"

  def install
    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python3.12/site-packages"
    system "python3.12", "-m", "pip", "install", "--target=#{libexec}/lib/python3.12/site-packages", "chuck-data==0.1.2"
    
    # Create wrapper script
    (bin/"chuck").write <<~EOS
      #!/bin/bash
      export PYTHONPATH="#{libexec}/lib/python3.12/site-packages:$PYTHONPATH"
      exec python3.12 -m chuck_data "$@"
    EOS
  end

  test do
    system "#{bin}/chuck", "--help"
  end
end
