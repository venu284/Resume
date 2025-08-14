# Resume Build System
# Automates LaTeX compilation and cleanup

# Configuration
MAIN_TEX = resume.tex
OUTPUT_PDF = resume.pdf
LATEX_CMD = pdflatex
LATEX_FLAGS = -interaction=nonstopmode

# Build targets
.PHONY: all build clean clean-all help pre-commit store-pdf

all: build

# Build the resume PDF
build:
	@echo "Building resume from $(MAIN_TEX)..."
	$(LATEX_CMD) $(LATEX_FLAGS) $(MAIN_TEX)
	@echo "Resume built successfully: $(OUTPUT_PDF)"

# Clean temporary files
clean:
	@echo "Cleaning temporary files..."
	@rm -f *.aux *.log *.out *.fdb_latexmk *.fls *.synctex.gz
	@echo "Temporary files cleaned."

# Clean all generated files including PDF
clean-all: clean
	@echo "Cleaning all generated files..."
	@rm -f $(OUTPUT_PDF)
	@echo "All generated files cleaned."

# Pre-commit hook - validate and build
pre-commit:
	@echo "Running pre-commit checks..."
	@if [ ! -f $(MAIN_TEX) ]; then \
		echo "ERROR: $(MAIN_TEX) not found!"; \
		exit 1; \
	fi
	@echo "LaTeX file exists, proceeding with build..."
	$(MAKE) build
	@echo "Pre-commit checks passed!"

# Store PDF with timestamp (for repeated use)
store-pdf: build
	@echo "Storing PDF with timestamp..."
	@mkdir -p builds
	@timestamp=$$(date +"%Y%m%d_%H%M%S"); \
	cp $(OUTPUT_PDF) "builds/resume_$$timestamp.pdf"; \
	echo "PDF stored as builds/resume_$$timestamp.pdf"
	@echo "Current PDF also available as $(OUTPUT_PDF)"

# Show help
help:
	@echo "Resume Build System"
	@echo "=================="
	@echo ""
	@echo "Available targets:"
	@echo "  build      - Build the resume PDF"
	@echo "  clean      - Clean temporary files"
	@echo "  clean-all  - Clean all generated files"
	@echo "  pre-commit - Run pre-commit validation and build"
	@echo "  store-pdf  - Build and store PDF with timestamp"
	@echo "  help       - Show this help message"
	@echo ""
	@echo "Example usage:"
	@echo "  make build     # Build resume.pdf"
	@echo "  make store-pdf # Build and store timestamped copy"
	@echo "  make clean     # Clean temporary files"