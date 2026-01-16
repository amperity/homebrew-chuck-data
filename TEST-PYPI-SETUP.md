# Test.PyPI Setup for chuck-data

This document explains how the test.pypi integration works for testing chuck-data releases before production.

## Architecture

### Two Parallel Workflows

**Production Flow (main branch)**:
1. Release published in `chuck-data` repo
2. Package published to PyPI
3. `update-formula.yml` updates `Formula/chuck-data.rb` on `main` branch
4. Users install: `brew install amperity/chuck-data/chuck-data`

**Test Flow (test-pypi branch)**:
1. Manual workflow trigger in `chuck-data` repo
2. Package published to test.pypi
3. `update-test-formula.yml` updates `Formula/chuck-data-test.rb` on `test-pypi` branch
4. Users install: `brew install https://raw.githubusercontent.com/amperity/homebrew-chuck-data/test-pypi/Formula/chuck-data-test.rb`

## Setup Steps

### 1. Create test-pypi branch in homebrew repo

```bash
cd /Users/punit/amperity/homebrew-chuck-data
git checkout -b test-pypi
git add Formula/chuck-data-test.rb .github/workflows/update-test-formula.yml
git commit -m "Add test.pypi support with chuck-data-test formula"
git push origin test-pypi
```

### 2. Verify secrets in chuck-data repo

Ensure these secrets exist in the `chuck-data` repository settings:
- `TEST_PYPI_API_TOKEN` - API token for test.pypi.org
- `RELEASE_UPDATE_TOKEN` - GitHub token with repo access to trigger workflows in homebrew-chuck-data

### 3. Push updated workflow to chuck-data repo

```bash
cd /Users/punit/amperity/chuck-data
git add .github/workflows/publish-test-pypi.yml
git commit -m "Add homebrew notification to test.pypi workflow"
git push
```

## Usage

### Publishing a Test Version

1. Go to chuck-data repo → Actions → "Publish to TestPyPI"
2. Click "Run workflow"
3. Wait for completion - it will automatically:
   - Build and publish to test.pypi
   - Trigger homebrew formula update
   - Update `chuck-data-test.rb` on `test-pypi` branch

### Installing Test Version

```bash
# Clean removal of all chuck-data versions
brew uninstall chuck-data 2>/dev/null
brew uninstall chuck-data-test 2>/dev/null
pip uninstall -y chuck-data 2>/dev/null
pip3 uninstall -y chuck-data 2>/dev/null

# Install test version
brew install https://raw.githubusercontent.com/amperity/homebrew-chuck-data/test-pypi/Formula/chuck-data-test.rb

# Verify installation
chuck --version
```

### Switching Between Versions

```bash
# Switch to test version
brew uninstall chuck-data
brew install https://raw.githubusercontent.com/amperity/homebrew-chuck-data/test-pypi/Formula/chuck-data-test.rb

# Switch to production version
brew uninstall chuck-data-test
brew install amperity/chuck-data/chuck-data
```

## Key Differences from Production

1. **Formula Name**: `chuck-data-test` vs `chuck-data`
2. **Branch**: Updates `test-pypi` branch instead of `main`
3. **Source**: Installs from test.pypi.org instead of pypi.org
4. **Trigger**: Manual workflow dispatch instead of release event
5. **No PR**: Commits directly to `test-pypi` branch (no PR/merge)

## Troubleshooting

### Package not found on test.pypi

The workflow waits 30 seconds for the package to become available. If it still fails:
- Check test.pypi.org to verify the package exists
- Verify the version number matches
- Try running the workflow again after a few minutes

### SHA256 mismatch

The workflow fetches SHA256 from test.pypi automatically. If there's an issue:
- Check that the package uploaded successfully
- Verify test.pypi.org shows the correct version

### Formula validation fails

- Check Ruby syntax: `ruby -c Formula/chuck-data-test.rb`
- Verify test.pypi URL is accessible
- Check workflow logs for detailed error messages

## Files Involved

**chuck-data repo**:
- `.github/workflows/publish-test-pypi.yml` - Publishes to test.pypi and notifies homebrew

**homebrew-chuck-data repo**:
- `Formula/chuck-data-test.rb` - Test formula (on `test-pypi` branch)
- `.github/workflows/update-test-formula.yml` - Updates test formula automatically
- `Formula/chuck-data.rb` - Production formula (on `main` branch, unchanged)
- `.github/workflows/update-formula.yml` - Production update workflow (unchanged)
