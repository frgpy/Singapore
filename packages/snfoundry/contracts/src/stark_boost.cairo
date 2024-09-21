#[starknet::contract]
mod IstarUser {
    use super::{IERC20, ContractAddress};

    #[storage]
    struct Storage {
        foundationPool: felt252,
        users: legacyMap<ContractAddress, User>
    }

    #[derive(Drop, starknet::Event)]
    struct User {
        twitter: bool,
        discord: bool,
        starkDomain: string,
        hasDomain: bool,
        numberOfTransaction: u8,
        age: u8,
        frequency: bool,
        maxAmount: bool,
        numberNFT: u8,
        refereal1: felt252,
        refereal2: felt252,
        authorized: bool,
        deposit: u16,
        credit: u16,
        delegate: u16,
        startTime: u256,
        duration: u256,
    }

    #[abi(embed_v0)]
    impl IstarUserImpl of super::IStarUser<ContractState> {
        // GET THE LOAN
        
        // Requests STRK from the foundation's pool
        fn get_token_from_foundation(self: TContractState, amount: u256) -> bool {
            let foundation_pool = self.foundationPool;
            require(amount <= foundation_pool, "Insufficient funds in the foundation pool");

            // Logic to deduct from foundationPool
            self.foundationPool = foundation_pool - amount;

            return true;
        }

        // Wraps the STRK received into vSTRK
        fn wrap_token(self: TContractState, amount: u256) -> bool {
            // Assume a function exists in the STRK contract to wrap the tokens
            let result = IERC20::<TContractState>::transfer(ref self, msg.sender, amount);
            require(result, "Wrapping failed");

            return true;
        }

        // Immediately delegates the wrapped STRK to the user
        fn delegate(self: TContractState, user: ContractAddress, amount: u256) -> bool {
            // Logic to delegate wrapped STRK to the user
            // This might involve calling an existing delegation function

            return true;
        }

        // Sends 60% or less of the foundation's STRK to the user
        fn send_left_token(self: TContractState, user: ContractAddress, total_amount: u256) -> bool {
            let amount_to_send = total_amount * 60 / 100;

            // Logic to transfer amount_to_send to the user
            let result = IERC20::<TContractState>::transfer(ref self, user, amount_to_send);
            require(result, "Transfer failed");

            return true;
        }

        // 2️⃣ PAYBACK THE LOAN
        
        // Remove the delegation to the user
        fn undelegate_token(self: TContractState, user: ContractAddress) -> bool {
            // Logic to undelegate the user's tokens
            return true;
        }

        // Unwraps vSTRK back to STRK
        fn unwrap_token(self: TContractState, amount: u256) -> bool {
            // Logic to unwrap vSTRK back to STRK
            return true;
        }

        // Send back the amount of the loan to the foundation + Send back the token to the user
        fn repay_user(self: TContractState, user: ContractAddress, amount: u256) -> bool {
            // Logic to repay the foundation
            self.foundationPool += amount;

            // Logic to send the tokens back to the user
            let result = IERC20::<TContractState>::transfer(ref self, user, amount);
            require(result, "Repayment transfer failed");

            return true;
        }
    }
}
