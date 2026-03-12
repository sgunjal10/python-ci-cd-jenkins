#!/bin/bash
set -e

echo "Running Python tests..."
pytest tests/ --maxfail=1 --disable-warnings
echo "Tests passed!"