#!/bin/bash
# Resume Build Script
# Provides automation for building and managing resume PDFs

set -e  # Exit on any error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Configuration
MAIN_TEX="resume.tex"
OUTPUT_PDF="resume.pdf"
BUILD_DIR="builds"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Helper functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if LaTeX is available
check_latex() {
    if ! command -v pdflatex &> /dev/null; then
        log_error "pdflatex not found. Please install LaTeX."
        exit 1
    fi
}

# Build the resume
build_resume() {
    log_info "Building resume from $MAIN_TEX..."
    
    if [ ! -f "$MAIN_TEX" ]; then
        log_error "$MAIN_TEX not found!"
        exit 1
    fi
    
    if pdflatex -interaction=nonstopmode "$MAIN_TEX" > /dev/null 2>&1; then
        log_success "Resume built successfully: $OUTPUT_PDF"
    else
        log_error "Failed to build resume. Check $MAIN_TEX for errors."
        exit 1
    fi
}

# Clean temporary files
clean_temp() {
    log_info "Cleaning temporary files..."
    rm -f *.aux *.log *.out *.fdb_latexmk *.fls *.synctex.gz
    log_success "Temporary files cleaned."
}

# Store PDF with timestamp
store_pdf() {
    build_resume
    
    log_info "Storing PDF with timestamp..."
    mkdir -p "$BUILD_DIR"
    
    timestamp=$(date +"%Y%m%d_%H%M%S")
    stored_file="$BUILD_DIR/resume_$timestamp.pdf"
    
    cp "$OUTPUT_PDF" "$stored_file"
    log_success "PDF stored as $stored_file"
    log_info "Current PDF also available as $OUTPUT_PDF"
}

# Pre-commit hook functionality
pre_commit() {
    log_info "Running pre-commit checks..."
    
    # Check if LaTeX file exists
    if [ ! -f "$MAIN_TEX" ]; then
        log_error "$MAIN_TEX not found!"
        exit 1
    fi
    
    # Check for basic LaTeX syntax (simple validation)
    if ! grep -q "\\documentclass" "$MAIN_TEX"; then
        log_error "$MAIN_TEX appears to be invalid (no \\documentclass found)"
        exit 1
    fi
    
    if ! grep -q "\\\\begin{document}" "$MAIN_TEX"; then
        log_error "$MAIN_TEX appears to be invalid (no \\begin{document} found)"
        exit 1
    fi
    
    if ! grep -q "\\\\end{document}" "$MAIN_TEX"; then
        log_error "$MAIN_TEX appears to be invalid (no \\end{document} found)"
        exit 1
    fi
    
    log_success "LaTeX file validation passed"
    
    # Build the resume
    build_resume
    
    log_success "Pre-commit checks completed successfully!"
}

# Show usage
show_usage() {
    echo "Resume Build Script"
    echo "=================="
    echo ""
    echo "Usage: $0 [command]"
    echo ""
    echo "Commands:"
    echo "  build      - Build the resume PDF"
    echo "  clean      - Clean temporary files"
    echo "  store      - Build and store PDF with timestamp"
    echo "  pre-commit - Run pre-commit validation and build"
    echo "  help       - Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 build      # Build resume.pdf"
    echo "  $0 store      # Build and store timestamped copy"
    echo "  $0 pre-commit # Validate and build (for git hooks)"
}

# Main script logic
main() {
    check_latex
    
    case "${1:-build}" in
        "build")
            build_resume
            ;;
        "clean")
            clean_temp
            ;;
        "store")
            store_pdf
            ;;
        "pre-commit")
            pre_commit
            ;;
        "help"|"-h"|"--help")
            show_usage
            ;;
        *)
            log_error "Unknown command: $1"
            show_usage
            exit 1
            ;;
    esac
}

# Run main function with all arguments
main "$@"