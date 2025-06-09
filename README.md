# Blockchain-Based Procurement Vendor Management System

A comprehensive smart contract system built on the Stacks blockchain using Clarity for managing procurement vendor relationships, contracts, payments, and compliance monitoring.

## Overview

This system provides a decentralized solution for procurement management with the following key features:

- **Vendor Verification**: Validate and manage vendor organizations
- **Performance Rating**: Track and rate vendor performance
- **Contract Management**: Manage vendor contracts and milestones
- **Payment Processing**: Handle payments through escrow mechanisms
- **Compliance Monitoring**: Monitor vendor compliance with regulations

## Smart Contracts

### 1. Vendor Verification Contract (\`vendor-verification.clar\`)

Manages vendor registration, verification, and document storage.

**Key Functions:**
- \`register-vendor\`: Register a new vendor
- \`verify-vendor\`: Verify a vendor with a specific level
- \`add-vendor-document\`: Add compliance documents
- \`get-vendor\`: Retrieve vendor information
- \`is-vendor-verified\`: Check verification status

### 2. Performance Rating Contract (\`performance-rating.clar\`)

Handles vendor performance ratings and maintains performance summaries.

**Key Functions:**
- \`submit-rating\`: Submit a performance rating (1-5 scale)
- \`get-vendor-performance\`: Get vendor performance summary
- \`get-rating\`: Get specific contract rating

### 3. Contract Management Contract (\`contract-management.clar\`)

Manages vendor contracts, milestones, and contract lifecycle.

**Key Functions:**
- \`create-contract\`: Create a new vendor contract
- \`add-milestone\`: Add milestones to contracts
- \`complete-milestone\`: Mark milestones as completed
- \`update-contract-status\`: Update contract status
- \`get-contract\`: Retrieve contract details

### 4. Payment Processing Contract (\`payment-processing.clar\`)

Handles payment processing through escrow mechanisms.

**Key Functions:**
- \`create-payment\`: Create a payment request
- \`deposit-escrow\`: Deposit funds to escrow
- \`process-payment\`: Process payments from escrow
- \`get-payment\`: Get payment details
- \`get-escrow-balance\`: Check escrow balance

### 5. Compliance Monitoring Contract (\`compliance-monitoring.clar\`)

Monitors vendor compliance with regulations and standards.

**Key Functions:**
- \`update-compliance-status\`: Update compliance records
- \`report-violation\`: Report compliance violations
- \`resolve-violation\`: Resolve reported violations
- \`get-compliance-status\`: Check compliance status
- \`get-violation\`: Get violation details

## Installation

1. Clone the repository:
   \`\`\`bash
   git clone <repository-url>
   cd blockchain-procurement
   \`\`\`

2. Install dependencies:
   \`\`\`bash
   npm install
   \`\`\`

3. Run tests:
   \`\`\`bash
   npm test
   \`\`\`

## Usage

### Deploying Contracts

Deploy the contracts to the Stacks blockchain in the following order:

1. Vendor Verification Contract
2. Performance Rating Contract
3. Contract Management Contract
4. Payment Processing Contract
5. Compliance Monitoring Contract

### Basic Workflow

1. **Vendor Registration**: Vendors register using \`register-vendor\`
2. **Verification**: Admin verifies vendors using \`verify-vendor\`
3. **Contract Creation**: Create contracts using \`create-contract\`
4. **Milestone Management**: Add and track milestones
5. **Payment Processing**: Process payments through escrow
6. **Performance Rating**: Rate vendor performance
7. **Compliance Monitoring**: Track compliance status

## Testing

The project includes comprehensive tests using Vitest:

\`\`\`bash
npm test
\`\`\`

Test files cover:
- Vendor verification functionality
- Performance rating system
- Contract management operations
- Payment processing workflows
- Compliance monitoring features

## Security Considerations

- All contracts include proper access controls
- Payment processing uses escrow mechanisms
- Compliance violations are tracked and must be resolved
- Performance ratings are immutable once submitted
- Contract modifications require proper authorization

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## License

This project is licensed under the MIT License.

## Support

For questions or support, please open an issue in the repository.
