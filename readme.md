# Shredlink Go

Go protobuf library for Shredlink - High-performance Solana transaction streaming service.

This library provides the generated protobuf types and gRPC service definitions for easy integration with Shredlink.

## Installation

```bash
go get github.com/your-username/shredlink-go
```

## Usage

```go
package main

import (
    "context"
    "io"
    "log"

    "google.golang.org/grpc"
    "google.golang.org/grpc/credentials/insecure"
    
    "github.com/your-username/shredlink-go"
)

func main() {
    // Connect to Shredlink service
    conn, err := grpc.Dial("your-shredlink-url:50051", 
        grpc.WithTransportCredentials(insecure.NewCredentials()))
    if err != nil {
        log.Fatal(err)
    }
    defer conn.Close()

    // Create client
    client := shredlink.NewShredlinkServiceClient(conn)

    // Subscribe to transactions
    stream, err := client.SubscribeTransactions(context.Background())
    if err != nil {
        log.Fatal(err)
    }

    // Create transaction filter
    filter := &shredlink.SubscribeRequestFilterTransactions{
        AccountRequired: []string{"TSLvdd1pWpHVjahSpsvCXUbgwsL3JAcvokwaKt1eokM"},
    }

    // Send subscription request
    request := &shredlink.SubscribeTransactionsRequest{
        Transactions: map[string]*shredlink.SubscribeRequestFilterTransactions{
            "pumpfun": filter,
        },
    }
    
    err = stream.Send(request)
    if err != nil {
        log.Fatal(err)
    }

    // Listen for responses
    for {
        response, err := stream.Recv()
        if err == io.EOF {
            break
        }
        if err != nil {
            log.Fatal(err)
        }
        
        // Process transaction
        if response.Transaction != nil {
            log.Printf("Slot: %d", response.Transaction.Slot)
            if tx := response.Transaction.Transaction; tx != nil {
                log.Printf("Signatures: %d", len(tx.Signatures))
            }
        }
    }
}
```

## Available Types

### Services
- `ShredlinkServiceClient` - Main gRPC client interface
- `ShredlinkService_SubscribeEntriesClient` - Entry subscription stream
- `ShredlinkService_SubscribeTransactionsClient` - Transaction subscription stream

### Request/Response Types
- `SubscribeEntriesRequest`
- `SubscribeTransactionsRequest`
- `SubscribeTransactionsResponse`
- `SubscribeRequestFilterTransactions`

### Data Types
- `Entry`
- `Transaction`
- `Message`
- `MessageHeader`
- `CompiledInstruction`
- `MessageAddressTableLookup`
- `SubscribeUpdateTransaction`

## Examples

For complete usage examples, see:
- [PumpFun Monitor Example](https://github.com/your-username/shredlink-golang-example)

## Protocol Buffer Definition

The protobuf definition is available in `shredlink.proto` for reference.

## Development

To regenerate the protobuf files:

```bash
./generate_proto.sh
```

## License

[Your License Here]
