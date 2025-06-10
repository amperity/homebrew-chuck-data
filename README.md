# Amperity Homebrew Tap

[![Homebrew](https://img.shields.io/badge/Homebrew-tap-orange.svg)](https://brew.sh/)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

This is the official Homebrew tap for Amperity's CLI tools and data engineering utilities.

## 🚀 Quick Start

```bash
# Add the tap
brew tap amperity/chuck

# Install chuck-data
brew install chuck-data

# Start using Chuck
chuck --help
```

## 📦 Available Packages

### chuck-data

**AI-powered customer data engineering assistant for Databricks**

Chuck is a text-based user interface (TUI) for managing Databricks resources including Unity Catalog, SQL warehouses, models, and volumes. Chuck Data provides an interactive shell environment for customer data engineering tasks with AI-powered assistance.

**Installation:**
```bash
brew install chuck-data
```

**Usage:**
```bash
chuck                    # Start interactive TUI
chuck --help            # Show help
chuck --version         # Show version
```

**Key Features:**
- 🤖 AI-powered "agentic" data engineering assistant
- 🔍 Browse Unity Catalog resources (catalogs, schemas, tables)
- 🏷️ Profile database tables with automated PII detection
- 🔗 Identity resolution powered by [Amperity's Stitch](https://docs.amperity.com/reference/stitch.html)
- 🚀 Use LLMs from your Databricks account via Model Serving
- 🛡️ Tag tables with semantic tags for compliance and data governance

**Documentation:** [chuck-data repository](https://github.com/amperity/chuck-data)

## 🛠️ Development

### Testing Formula Changes

```bash
# Test installation locally
brew install --formula ./Formula/chuck-data.rb

# Run formula tests
brew test chuck-data

# Clean up
brew uninstall chuck-data
```

### Adding New Packages

1. Create a new formula in the `Formula/` directory
2. Follow [Homebrew formula conventions](https://docs.brew.sh/Formula-Cookbook)
3. Test thoroughly before submitting

## 📋 Requirements

- macOS with Homebrew installed
- Python 3.10+ (automatically handled by the formula)

## 🤝 Support

### Chuck Data Support
- **GitHub Issues**: https://github.com/amperity/chuck-data/issues
- **Discord Community**: https://discord.gg/f3UZwyuQqe
- **Email Support**: chuck-support@amperity.com

### Homebrew Tap Issues
- **Issues with this tap**: [Create an issue](https://github.com/amperity/homebrew-chuck/issues)

## 📄 License

This tap is licensed under the Apache License 2.0. See individual package licenses for their respective terms.

---

*Made with ❤️ by [Amperity](https://amperity.com)*