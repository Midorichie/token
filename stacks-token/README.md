# Hammed Token (HAM) – Phase 2

## Updates
This is an improved version of the original token contract, featuring:
- Prevention of zero-value transfers
- New functionality: `burn` method to destroy tokens
- Improved security checks

## Features
- Fixed total supply (1,000,000 HAM)
- Balance tracking
- Transfer function
- Token burning

## Setup

### Prerequisites
- Install Clarinet from [Stacks documentation](https://docs.stacks.co/docs/clarity/clarinet/overview/)

### Run Project
```bash
clarinet check
clarinet test
```

### Contracts
- `token.clar` - Main token logic
- `burn.clar` - Allows users to burn (destroy) part of their balance

## Author
Hammed Yakub
