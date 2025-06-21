# Shredlink Go

Go protobuf library for Shredlink - High-performance Solana transaction streaming service.

This library provides the generated protobuf types and gRPC service definitions for easy integration with Shredlink.

## Installation

```bash
go get github.com/shredlink/shredlink-package-go
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


