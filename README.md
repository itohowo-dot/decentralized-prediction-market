# Decentralized Prediction Market Smart Contract

A Clarity smart contract for creating and managing decentralized prediction markets on the Stacks blockchain. Users can stake STX tokens to predict price movements and earn rewards for correct predictions.

## Features

- Create prediction markets with customizable parameters
- Make price movement predictions with STX stakes
- Oracle-based market resolution
- Automated reward distribution
- Built-in fee mechanism
- Administrative controls and safety measures

## Contract Overview

### Market Lifecycle

1. **Market Creation**

   - Contract owner creates markets with:
     - Starting price
     - Start block height
     - End block height
   - Each market gets a unique ID

2. **Prediction Phase**

   - Users stake STX (minimum 1 STX)
   - Choose "up" or "down" prediction
   - Stakes are locked until market resolution

3. **Resolution**

   - Oracle provides final price after end block
   - Winners determined by price movement
   - Rewards calculated proportionally to stakes

4. **Claims**
   - Winners can claim rewards
   - Platform fee (default 2%) deducted
   - Rewards distributed automatically

## Functions

### Market Management

```clarity
(define-public (create-market (start-price uint) (start-block uint) (end-block uint)))
```

Creates a new prediction market with specified parameters.

### User Functions

```clarity
(define-public (make-prediction (market-id uint) (prediction (string-ascii 4)) (stake uint)))
```

Make a prediction on a market by staking STX.

```clarity
(define-public (claim-winnings (market-id uint)))
```

Claim winnings from a correctly predicted market.

### Oracle Functions

```clarity
(define-public (resolve-market (market-id uint) (end-price uint)))
```

Oracle resolves market with final price.

### Read-Only Functions

```clarity
(define-read-only (get-market (market-id uint)))
(define-read-only (get-user-prediction (market-id uint) (user principal)))
(define-read-only (get-contract-balance))
```

### Administrative Functions

```clarity
(define-public (set-oracle-address (new-address principal)))
(define-public (set-minimum-stake (new-minimum uint)))
(define-public (set-fee-percentage (new-fee uint)))
(define-public (withdraw-fees (amount uint)))
```

## Error Codes

| Code | Description                 |
| ---- | --------------------------- |
| u100 | Owner-only action           |
| u101 | Market/prediction not found |
| u102 | Invalid prediction          |
| u103 | Market closed               |
| u104 | Already claimed             |
| u105 | Insufficient balance        |
| u106 | Invalid parameter           |

## Security Features

1. **Access Control**

   - Owner-only administrative functions
   - Oracle-only market resolution
   - User-specific claim protection

2. **Safety Checks**

   - Minimum stake requirements
   - Balance validations
   - Market timing validations
   - Double-claim prevention

3. **Parameter Validation**
   - Price validation
   - Block height checks
   - Prediction format validation

## Contract Variables

| Variable       | Type      | Default   | Description               |
| -------------- | --------- | --------- | ------------------------- |
| minimum-stake  | uint      | 1,000,000 | Minimum STX stake (1 STX) |
| fee-percentage | uint      | 2         | Platform fee percentage   |
| oracle-address | principal | ST1PQ...  | Oracle wallet address     |

## Usage Examples

### Creating a Market

```clarity
(contract-call? .prediction-market create-market u1000000 u10000 u20000)
```

### Making a Prediction

```clarity
(contract-call? .prediction-market make-prediction u1 "up" u1000000)
```

### Claiming Winnings

```clarity
(contract-call? .prediction-market claim-winnings u1)
```

## Best Practices

1. **For Users**

   - Verify market parameters before staking
   - Ensure sufficient STX balance
   - Check market status before claiming

2. **For Administrators**
   - Regular oracle address verification
   - Monitor fee accumulation
   - Validate market parameters

## Development and Testing

1. **Local Testing**

   ```bash
   clarinet test
   ```

2. **Deployment**
   ```bash
   clarinet deploy --network testnet
   ```

## License

MIT License - See LICENSE file for details

## Contributing

1. Fork the repository
2. Create feature branch
3. Commit changes
4. Push to branch
5. Create Pull Request
