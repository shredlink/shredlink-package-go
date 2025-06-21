#!/bin/bash

# Shredlink Go Library Proto Generator
echo "🚀 Shredlink Go Library Proto Generator"
echo "----------------------------------------"

# Get GOPATH and set up PATH
GOPATH=$(go env GOPATH)
export PATH="$GOPATH/bin:$PATH"

# Check if protoc is installed
if ! command -v protoc &> /dev/null; then
    echo "❌ protoc is not installed. Please install Protocol Buffers compiler:"
    echo "   brew install protobuf  # macOS"
    echo "   apt install protobuf-compiler  # Ubuntu/Debian"
    exit 1
fi

# Check if protoc-gen-go is installed
if ! command -v protoc-gen-go &> /dev/null; then
    echo "🔧 Installing protoc-gen-go..."
    go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
    export PATH="$GOPATH/bin:$PATH"
fi

# Check if protoc-gen-go-grpc is installed
if ! command -v protoc-gen-go-grpc &> /dev/null; then
    echo "🔧 Installing protoc-gen-go-grpc..."
    go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.3.0
    export PATH="$GOPATH/bin:$PATH"
fi

echo "🔧 Generating Go gRPC code for library..."

# Generate Go code in root directory (library structure)
protoc --plugin=protoc-gen-go="$GOPATH/bin/protoc-gen-go" \
       --plugin=protoc-gen-go-grpc="$GOPATH/bin/protoc-gen-go-grpc" \
       --go_out=. --go_opt=paths=source_relative \
       --go-grpc_out=. --go-grpc_opt=paths=source_relative \
       shredlink.proto

if [ $? -eq 0 ]; then
    echo "✅ Successfully generated Go gRPC library code!"
    echo "📁 Generated files:"
    echo "   - shredlink.pb.go (message structs)"
    echo "   - shredlink_grpc.pb.go (service interfaces)"
    echo ""
    echo "🎉 Library generation completed successfully!"
    echo ""
    echo "📖 Next steps:"
    echo "1. Run: go mod tidy"
    echo "2. Commit the generated files to git"
    echo "3. Users can now: go get your-module-name"
else
    echo "❌ Error generating gRPC library code!"
    exit 1
fi 