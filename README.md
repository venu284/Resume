# Resume Repository

A LaTeX-based resume generation system for Venu Dattathreya Vemuru with automated build tools and version control.

## 📋 What This Repository Does

This repository provides:

- **LaTeX Resume Source**: Professional resume written in LaTeX (`resume.tex`)
- **Automated Building**: Scripts and Makefiles for easy PDF generation
- **Version Control**: Git hooks for validation and automated builds
- **Timestamped Storage**: Automated storage of resume versions
- **Pre-commit Validation**: Ensures resume builds successfully before commits

## 🚀 Quick Start

### Prerequisites

- LaTeX distribution (texlive)
- Make (for Makefile usage)
- Git (for version control features)

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd Resume
```

2. Install LaTeX (if not already installed):
```bash
# Ubuntu/Debian
sudo apt-get install texlive-latex-base texlive-latex-extra texlive-latex-recommended

# macOS with Homebrew
brew install mactex

# Windows
# Download and install MiKTeX or TeX Live
```

## 🛠️ Usage

### Building the Resume

#### Using Make (Recommended)
```bash
# Build resume.pdf
make build

# Build and store timestamped copy
make store-pdf

# Clean temporary files
make clean

# Show all available commands
make help
```

#### Using Build Script
```bash
# Build resume.pdf
./build.sh build

# Build and store timestamped copy
./build.sh store

# Run pre-commit validation
./build.sh pre-commit

# Show help
./build.sh help
```

#### Manual Building
```bash
pdflatex resume.tex
```

### Store Pre Command (For Repeated Use)

The "store pre command" you mentioned is implemented as:

```bash
# Quick build and store
make store-pdf
# OR
./build.sh store
```

This command:
1. Validates the LaTeX file
2. Builds the resume PDF
3. Creates a timestamped copy in the `builds/` directory
4. Keeps the current `resume.pdf` for immediate use

### Automated Workflows

#### Pre-commit Hook
The repository includes a git pre-commit hook that:
- Validates the LaTeX syntax
- Builds the resume
- Ensures it compiles without errors

This runs automatically before each commit to prevent broken code from being committed.

#### Continuous Integration
For automated building on every push, the build scripts are designed to work with CI/CD systems.

## 📁 File Structure

```
Resume/
├── resume.tex           # Main LaTeX resume file
├── resume.pdf          # Generated PDF (current version)
├── builds/             # Timestamped PDF storage
├── Makefile           # Build automation
├── build.sh           # Build script with validation
├── .git/hooks/        # Git hooks for automation
└── README.md          # This file
```

## 🔧 Available Commands

### Make Commands
- `make build` - Build the resume PDF
- `make clean` - Remove temporary LaTeX files
- `make clean-all` - Remove all generated files including PDF
- `make pre-commit` - Run validation and build (used by git hooks)
- `make store-pdf` - Build and store timestamped copy
- `make help` - Show available commands

### Build Script Commands
- `./build.sh build` - Build the resume PDF
- `./build.sh clean` - Remove temporary files
- `./build.sh store` - Build and store timestamped copy
- `./build.sh pre-commit` - Run validation and build
- `./build.sh help` - Show available commands

## 🎯 Key Features

### 1. Automated PDF Generation
- One-command building with error handling
- Automatic cleanup of temporary files
- Validation before building

### 2. Version Control Integration
- Pre-commit hooks ensure valid LaTeX
- Automatic building before commits
- Git integration for tracking changes

### 3. Timestamped Storage
- Automatic storage of resume versions
- Organized in `builds/` directory
- Preserves current version as `resume.pdf`

### 4. Error Handling
- Comprehensive validation of LaTeX files
- Clear error messages and logging
- Graceful failure handling

## 🔄 Workflow Examples

### Daily Usage
```bash
# Edit resume.tex
vim resume.tex

# Build and store new version
make store-pdf

# The system automatically:
# 1. Validates the LaTeX
# 2. Builds the PDF
# 3. Stores timestamped copy
# 4. Updates current resume.pdf
```

### Git Workflow
```bash
# Edit resume
vim resume.tex

# Commit changes (automatically triggers validation and build)
git add resume.tex
git commit -m "Update experience section"

# The pre-commit hook automatically:
# 1. Validates LaTeX syntax
# 2. Builds the resume
# 3. Ensures it compiles successfully
```

### Batch Operations
```bash
# Clean and rebuild everything
make clean-all && make build

# Store multiple versions
for i in {1..5}; do make store-pdf; sleep 1; done
```

## 🚨 Troubleshooting

### LaTeX Compilation Errors
```bash
# Check for errors manually
pdflatex resume.tex

# View detailed log
cat resume.log
```

### Missing Dependencies
```bash
# Check if LaTeX is installed
which pdflatex

# Install missing packages (Ubuntu/Debian)
sudo apt-get install texlive-fonts-recommended
```

### Permission Issues
```bash
# Make scripts executable
chmod +x build.sh
chmod +x .git/hooks/pre-commit
```

## 📝 Customization

### Modifying the Resume
1. Edit `resume.tex` with your information
2. Use `make build` to test changes
3. Use `make store-pdf` to save versions

### Adding New Build Steps
1. Modify `Makefile` for Make-based builds
2. Update `build.sh` for script-based builds
3. Test with `make help` or `./build.sh help`

### Custom Storage Locations
Edit the `BUILD_DIR` variable in `build.sh`:
```bash
BUILD_DIR="custom-output-directory"
```

## 🤝 Contributing

1. Fork the repository
2. Make your changes
3. Test with `make build`
4. Submit a pull request

The pre-commit hooks will ensure code quality and that the resume builds successfully.

## 📄 License

MIT License - See the LaTeX file header for details.

---

**Note**: This system is designed to handle the "store pre command" you mentioned through the automated build and storage workflows. The `make store-pdf` and `./build.sh store` commands provide the repeated functionality you need for managing resume versions efficiently.