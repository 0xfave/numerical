# Sstan - v0.1.0 

 --- 
 TODO: add description

# Summary




## Vulnerabilities 

 | Classification | Title | Instances | 
 |:-------:|:---------|:-------:| 
 | [[High-0]](#[High-0]) | Uninitialized storage variables | 1 |
 | [[Low-1]](#[Low-1]) | Use a locked pragma version instead of a floating pragma version | 6 |
 | [[Low-2]](#[Low-2]) | Unsafe ERC20 Operation | 7 |
## Optimizations 

 | Classification | Title | Instances | 
 |:-------:|:---------|:-------:| 
 | [[Gas-0]](#[Gas-0]) | Avoid Reading From Storage in a for loop | 1 |
 | [[Gas-1]](#[Gas-1]) | Mark storage variables as `constant` if they never change. | 1 |
 | [[Gas-2]](#[Gas-2]) | Mark storage variables as `immutable` if they never change after contract initialization. | 1 |
 | [[Gas-3]](#[Gas-3]) | `unchecked{++i}` instead of `i++` (or use assembly when applicable) | 1 |
 | [[Gas-4]](#[Gas-4]) | Cache Storage Variables in Memory | 1 |
 | [[Gas-5]](#[Gas-5]) | Use assembly to check for address(0) | 1 |
 | [[Gas-6]](#[Gas-6]) | Optimal Comparison | 1 |
 | [[Gas-7]](#[Gas-7]) | Use `calldata` instead of `memory` for function arguments that do not get mutated. | 1 |
 | [[Gas-8]](#[Gas-8]) | Use assembly for math (add, sub, mul, div) | 1 |
 | [[Gas-9]](#[Gas-9]) | Use assembly to write storage values | 1 |
 | [[Gas-10]](#[Gas-10]) | Event is not properly indexed. | 1 |
 | [[Gas-11]](#[Gas-11]) | Mark functions as payable (with discretion) | 1 |
 | [[Gas-12]](#[Gas-12]) | Cache array length during for loop definition. | 1 |
 | [[Gas-13]](#[Gas-13]) | Short Revert Strings | 1 |
## Quality Assurance 

 | Classification | Title | Instances | 
 |:-------:|:---------|:-------:| 
 | [[NonCritical-0]](#[NonCritical-0]) | Constructor should be listed before any other function | 1 |
 | [[NonCritical-1]](#[NonCritical-1]) | Constructor should check that all parameters are not 0 | 2 |
 | [[NonCritical-2]](#[NonCritical-2]) | Contract names should be in PascalCase | 1 |
 | [[NonCritical-3]](#[NonCritical-3]) | Large contracts with many external functions should inherit an interface | 1 |
 | [[NonCritical-4]](#[NonCritical-4]) | Storage variables should not have implicit visibility | 7 |
 | [[NonCritical-5]](#[NonCritical-5]) | Function names should be in camelCase | 18 |
 | [[NonCritical-6]](#[NonCritical-6]) | Require/Revert statements should be consistent across the codebase | 2 |
 | [[NonCritical-7]](#[NonCritical-7]) | Only define one contract per file | 2 |
 | [[NonCritical-8]](#[NonCritical-8]) | Constant and immutable variable names should be in SCREAMING_SNAKE_CASE | 2 |
 | [[NonCritical-9]](#[NonCritical-9]) | Consider marking public function External | 10 |
 | [[NonCritical-10]](#[NonCritical-10]) | Consider adding a message with require and revert statements | 16 |
 | [[NonCritical-11]](#[NonCritical-11]) | Remove any unused functions | 5 |
 | [[NonCritical-12]](#[NonCritical-12]) | This variable's default value is the same as the value it is initialized with | 3 |
 | [[NonCritical-13]](#[NonCritical-13]) | Function parameters should be in camelCase | 48 |
 | [[NonCritical-14]](#[NonCritical-14]) | Consider explicitly naming mapping parameters | 3 |

## Vulnerabilities - Total: 14 

<a name=[High-0]></a>
### [High-0] Uninitialized storage variables - Instances: 1 

 > A storage variable that is declared but not initialized will have a default value of zero (or the equivalent, such as an empty array for array types or zero-address for address types). Failing to initialize a storage variable can pose risks if the contract logic assumes that the variable has been explicitly set to a particular value. 

 --- 

File:Contract.sol#L596
```solidity
595:    uint256 decimals = 6;
``` 



 --- 

<a name=[Low-1]></a>
### [Low-1] Use a locked pragma version instead of a floating pragma version - Instances: 6 

 > ""
        Floating pragma is a vulnerability in smart contract code that can cause unexpected behavior by allowing the compiler to use a specified range of versions. \n This can lead to issues such as using an older compiler version with known vulnerabilities, using a newer compiler version with undiscovered vulnerabilities, inconsistency across files using different versions, or unpredictable behavior because the compiler can use any version within the specified range. It is recommended to use a locked pragma version in order to avoid these potential vulnerabilities. In some cases it may be acceptable to use a floating pragma, such as when a contract is intended for consumption by other developers and needs to be compatible with a range of compiler versions.
        <details>
        <summary>Expand Example</summary>

        #### Bad

        ```js
            pragma solidity ^0.8.0;
        ```

        #### Good

        ```js
            pragma solidity 0.8.15;
        ```
        </details>
        "" 

 --- 

File:Contract.sol#L6
```solidity
5:pragma solidity ^0.8.0;
``` 



File:Contract.sol#L87
```solidity
86:pragma solidity ^0.8.0;
``` 



File:Contract.sol#L117
```solidity
116:pragma solidity ^0.8.0;
``` 



File:Contract.sol#L144
```solidity
143:pragma solidity ^0.8.0;
``` 



File:Contract.sol#L511
```solidity
510:pragma solidity ^0.8.0;
``` 



File:Contract.sol#L589
```solidity
588:pragma solidity ^0.8.24;
``` 



 --- 

<a name=[Low-2]></a>
### [Low-2] Unsafe ERC20 Operation - Instances: 7 

 > ""
        ERC20 operations can be unsafe due to different implementations and vulnerabilities in the standard. To account for this, either use OpenZeppelin's SafeERC20 library or wrap each operation in a require statement. \n
        > Additionally, ERC20's approve functions have a known race-condition vulnerability. To account for this, use OpenZeppelin's SafeERC20 library's `safeIncrease` or `safeDecrease` Allowance functions.
        <details>
        <summary>Expand Example</summary>

        #### Unsafe Transfer

        ```js
        IERC20(token).transfer(msg.sender, amount);
        ```

        #### OpenZeppelin SafeTransfer

        ```js
        import {SafeERC20} from \"openzeppelin/token/utils/SafeERC20.sol\";
        //--snip--

        IERC20(token).safeTransfer(msg.sender, address(this), amount);
        ```
                
        #### Safe Transfer with require statement.

        ```js
        bool success = IERC20(token).transfer(msg.sender, amount);
        require(success, \"ERC20 transfer failed\");
        ```
                
        #### Unsafe TransferFrom

        ```js
        IERC20(token).transferFrom(msg.sender, address(this), amount);
        ```

        #### OpenZeppelin SafeTransferFrom

        ```js
        import {SafeERC20} from \"openzeppelin/token/utils/SafeERC20.sol\";
        //--snip--

        IERC20(token).safeTransferFrom(msg.sender, address(this), amount);
        ```
                
        #### Safe TransferFrom with require statement.

        ```js
        bool success = IERC20(token).transferFrom(msg.sender, address(this), amount);
        require(success, \"ERC20 transfer failed\");
        ```

        </details>
        "" 

 --- 

File:Contract.sol#L685
```solidity
684:        require(usdcAddress.transfer(adminWallet, usdcAddress.balanceOf(address(this))));
``` 



File:Contract.sol#L708
```solidity
707:        require(usdcAddress.transferFrom(msg.sender, adminWallet, amount));
``` 



File:Contract.sol#L783
```solidity
782:        bool sent = usdcAddress.transferFrom(adminWallet, address(this), totalWithdrawAmount);
``` 



File:Contract.sol#L827
```solidity
826:        require(usdcAddress.transfer(msg.sender, amountToSend));
``` 



File:Contract.sol#L841
```solidity
840:        bool sent = usdcAddress.transferFrom(adminWallet, address(this), amount);
``` 



File:Contract.sol#L854
```solidity
853:        require(usdcAddress.transfer(msg.sender, userReward));
``` 



File:Contract.sol#L874
```solidity
873:        require(usdcAddress.transfer(adminWallet, userReward));
``` 



 --- 



## Optimizations - Total: 14 

<a name=[Gas-0]></a>
### [Gas-0] Avoid Reading From Storage in a for loop - Instances: 1 

 > 
  - Savings: ~0 
 

 --- 

File:Contract.sol#L712
```solidity
711:        for (uint i = 0; i < awaitingApproval.length; i++) 
712:        {
713:            depositor storage user = userDepositInfo[awaitingApproval[i]];
714:            if(findAddressIndex(sucessfullyDeposited, awaitingApproval[i]) > sucessfullyDeposited.length){
715:                sucessfullyDeposited.push(awaitingApproval[i]);
716:            }
717:
718:            uint256 pendingAmount = user.pendingAmount;
719:
720:            user.amount += pendingAmount;
721:            user.pendingAmount = 0;
722:
723:            totalDeposited += pendingAmount;
724:
725:        }
``` 



File:Contract.sol#L712
```solidity
711:        for (uint i = 0; i < awaitingApproval.length; i++) 
712:        {
713:            depositor storage user = userDepositInfo[awaitingApproval[i]];
714:            if(findAddressIndex(sucessfullyDeposited, awaitingApproval[i]) > sucessfullyDeposited.length){
715:                sucessfullyDeposited.push(awaitingApproval[i]);
716:            }
717:
718:            uint256 pendingAmount = user.pendingAmount;
719:
720:            user.amount += pendingAmount;
721:            user.pendingAmount = 0;
722:
723:            totalDeposited += pendingAmount;
724:
725:        }
``` 



File:Contract.sol#L740
```solidity
739:        for (uint i = 0; i < withdrawRequests.length; i++) 
740:        {
741:            depositor storage user = userDepositInfo[withdrawRequests[i]];
742:            uint256 withdrawAmount = user.withrawalRequestAmount;
743:
744:            // take the amount from the pending first
745:            if(user.pendingAmount > 0){
746:                if(withdrawAmount > user.pendingAmount){
747:                    withdrawAmount -= user.pendingAmount;
748:                    totalPending -= user.pendingAmount;
749:                    user.pendingAmount = 0;
750:
751:                    // user has no more pending amount, delete address from awaitingApproval array
752:                    awaitingApproval = deleteAddressFromArray(awaitingApproval, withdrawRequests[i]);
753:                }else{
754:                    user.pendingAmount -= withdrawAmount;
755:                    totalPending -= withdrawAmount;
756:                    withdrawAmount = 0;
757:                }
758:            }
759:
760:            // take the rest from the deposited amount
761:            if(withdrawAmount > 0){
762:                user.amount -= withdrawAmount;
763:
764:                // total deposit decreases by the amount removed from amount, not from pending amount
765:                totalDeposited -= withdrawAmount;
766:            }
767:
768:            totalWithdrawAmount += user.withrawalRequestAmount;
769:
770:            user.withdrawApproved = true;
771:            user.withdrawableAmount = user.withrawalRequestAmount;
772:            user.withrawalRequestAmount = 0;
773:
774:            // user has no more deposit left, remove from sucessfullyDeposited array
775:            if(user.amount == 0){
776:                sucessfullyDeposited = deleteAddressFromArray(sucessfullyDeposited, withdrawRequests[i]);
777:            }
778:        }
``` 



File:Contract.sol#L740
```solidity
739:        for (uint i = 0; i < withdrawRequests.length; i++) 
740:        {
741:            depositor storage user = userDepositInfo[withdrawRequests[i]];
742:            uint256 withdrawAmount = user.withrawalRequestAmount;
743:
744:            // take the amount from the pending first
745:            if(user.pendingAmount > 0){
746:                if(withdrawAmount > user.pendingAmount){
747:                    withdrawAmount -= user.pendingAmount;
748:                    totalPending -= user.pendingAmount;
749:                    user.pendingAmount = 0;
750:
751:                    // user has no more pending amount, delete address from awaitingApproval array
752:                    awaitingApproval = deleteAddressFromArray(awaitingApproval, withdrawRequests[i]);
753:                }else{
754:                    user.pendingAmount -= withdrawAmount;
755:                    totalPending -= withdrawAmount;
756:                    withdrawAmount = 0;
757:                }
758:            }
759:
760:            // take the rest from the deposited amount
761:            if(withdrawAmount > 0){
762:                user.amount -= withdrawAmount;
763:
764:                // total deposit decreases by the amount removed from amount, not from pending amount
765:                totalDeposited -= withdrawAmount;
766:            }
767:
768:            totalWithdrawAmount += user.withrawalRequestAmount;
769:
770:            user.withdrawApproved = true;
771:            user.withdrawableAmount = user.withrawalRequestAmount;
772:            user.withrawalRequestAmount = 0;
773:
774:            // user has no more deposit left, remove from sucessfullyDeposited array
775:            if(user.amount == 0){
776:                sucessfullyDeposited = deleteAddressFromArray(sucessfullyDeposited, withdrawRequests[i]);
777:            }
778:        }
``` 



File:Contract.sol#L740
```solidity
739:        for (uint i = 0; i < withdrawRequests.length; i++) 
740:        {
741:            depositor storage user = userDepositInfo[withdrawRequests[i]];
742:            uint256 withdrawAmount = user.withrawalRequestAmount;
743:
744:            // take the amount from the pending first
745:            if(user.pendingAmount > 0){
746:                if(withdrawAmount > user.pendingAmount){
747:                    withdrawAmount -= user.pendingAmount;
748:                    totalPending -= user.pendingAmount;
749:                    user.pendingAmount = 0;
750:
751:                    // user has no more pending amount, delete address from awaitingApproval array
752:                    awaitingApproval = deleteAddressFromArray(awaitingApproval, withdrawRequests[i]);
753:                }else{
754:                    user.pendingAmount -= withdrawAmount;
755:                    totalPending -= withdrawAmount;
756:                    withdrawAmount = 0;
757:                }
758:            }
759:
760:            // take the rest from the deposited amount
761:            if(withdrawAmount > 0){
762:                user.amount -= withdrawAmount;
763:
764:                // total deposit decreases by the amount removed from amount, not from pending amount
765:                totalDeposited -= withdrawAmount;
766:            }
767:
768:            totalWithdrawAmount += user.withrawalRequestAmount;
769:
770:            user.withdrawApproved = true;
771:            user.withdrawableAmount = user.withrawalRequestAmount;
772:            user.withrawalRequestAmount = 0;
773:
774:            // user has no more deposit left, remove from sucessfullyDeposited array
775:            if(user.amount == 0){
776:                sucessfullyDeposited = deleteAddressFromArray(sucessfullyDeposited, withdrawRequests[i]);
777:            }
778:        }
``` 



File:Contract.sol#L740
```solidity
739:        for (uint i = 0; i < withdrawRequests.length; i++) 
740:        {
741:            depositor storage user = userDepositInfo[withdrawRequests[i]];
742:            uint256 withdrawAmount = user.withrawalRequestAmount;
743:
744:            // take the amount from the pending first
745:            if(user.pendingAmount > 0){
746:                if(withdrawAmount > user.pendingAmount){
747:                    withdrawAmount -= user.pendingAmount;
748:                    totalPending -= user.pendingAmount;
749:                    user.pendingAmount = 0;
750:
751:                    // user has no more pending amount, delete address from awaitingApproval array
752:                    awaitingApproval = deleteAddressFromArray(awaitingApproval, withdrawRequests[i]);
753:                }else{
754:                    user.pendingAmount -= withdrawAmount;
755:                    totalPending -= withdrawAmount;
756:                    withdrawAmount = 0;
757:                }
758:            }
759:
760:            // take the rest from the deposited amount
761:            if(withdrawAmount > 0){
762:                user.amount -= withdrawAmount;
763:
764:                // total deposit decreases by the amount removed from amount, not from pending amount
765:                totalDeposited -= withdrawAmount;
766:            }
767:
768:            totalWithdrawAmount += user.withrawalRequestAmount;
769:
770:            user.withdrawApproved = true;
771:            user.withdrawableAmount = user.withrawalRequestAmount;
772:            user.withrawalRequestAmount = 0;
773:
774:            // user has no more deposit left, remove from sucessfullyDeposited array
775:            if(user.amount == 0){
776:                sucessfullyDeposited = deleteAddressFromArray(sucessfullyDeposited, withdrawRequests[i]);
777:            }
778:        }
``` 



File:Contract.sol#L740
```solidity
739:        for (uint i = 0; i < withdrawRequests.length; i++) 
740:        {
741:            depositor storage user = userDepositInfo[withdrawRequests[i]];
742:            uint256 withdrawAmount = user.withrawalRequestAmount;
743:
744:            // take the amount from the pending first
745:            if(user.pendingAmount > 0){
746:                if(withdrawAmount > user.pendingAmount){
747:                    withdrawAmount -= user.pendingAmount;
748:                    totalPending -= user.pendingAmount;
749:                    user.pendingAmount = 0;
750:
751:                    // user has no more pending amount, delete address from awaitingApproval array
752:                    awaitingApproval = deleteAddressFromArray(awaitingApproval, withdrawRequests[i]);
753:                }else{
754:                    user.pendingAmount -= withdrawAmount;
755:                    totalPending -= withdrawAmount;
756:                    withdrawAmount = 0;
757:                }
758:            }
759:
760:            // take the rest from the deposited amount
761:            if(withdrawAmount > 0){
762:                user.amount -= withdrawAmount;
763:
764:                // total deposit decreases by the amount removed from amount, not from pending amount
765:                totalDeposited -= withdrawAmount;
766:            }
767:
768:            totalWithdrawAmount += user.withrawalRequestAmount;
769:
770:            user.withdrawApproved = true;
771:            user.withdrawableAmount = user.withrawalRequestAmount;
772:            user.withrawalRequestAmount = 0;
773:
774:            // user has no more deposit left, remove from sucessfullyDeposited array
775:            if(user.amount == 0){
776:                sucessfullyDeposited = deleteAddressFromArray(sucessfullyDeposited, withdrawRequests[i]);
777:            }
778:        }
``` 



File:Contract.sol#L740
```solidity
739:        for (uint i = 0; i < withdrawRequests.length; i++) 
740:        {
741:            depositor storage user = userDepositInfo[withdrawRequests[i]];
742:            uint256 withdrawAmount = user.withrawalRequestAmount;
743:
744:            // take the amount from the pending first
745:            if(user.pendingAmount > 0){
746:                if(withdrawAmount > user.pendingAmount){
747:                    withdrawAmount -= user.pendingAmount;
748:                    totalPending -= user.pendingAmount;
749:                    user.pendingAmount = 0;
750:
751:                    // user has no more pending amount, delete address from awaitingApproval array
752:                    awaitingApproval = deleteAddressFromArray(awaitingApproval, withdrawRequests[i]);
753:                }else{
754:                    user.pendingAmount -= withdrawAmount;
755:                    totalPending -= withdrawAmount;
756:                    withdrawAmount = 0;
757:                }
758:            }
759:
760:            // take the rest from the deposited amount
761:            if(withdrawAmount > 0){
762:                user.amount -= withdrawAmount;
763:
764:                // total deposit decreases by the amount removed from amount, not from pending amount
765:                totalDeposited -= withdrawAmount;
766:            }
767:
768:            totalWithdrawAmount += user.withrawalRequestAmount;
769:
770:            user.withdrawApproved = true;
771:            user.withdrawableAmount = user.withrawalRequestAmount;
772:            user.withrawalRequestAmount = 0;
773:
774:            // user has no more deposit left, remove from sucessfullyDeposited array
775:            if(user.amount == 0){
776:                sucessfullyDeposited = deleteAddressFromArray(sucessfullyDeposited, withdrawRequests[i]);
777:            }
778:        }
``` 



File:Contract.sol#L832
```solidity
831:        for (uint i = 0; i < sucessfullyDeposited.length; i++) 
832:        {
833:            depositor storage userInfo = userDepositInfo[sucessfullyDeposited[i]];
834:            uint256 userReward = userInfo.amount * amount / totalDeposited;
835:
836:            userInfo.claimableRewards += userReward;
837:        }
``` 



File:Contract.sol#L832
```solidity
831:        for (uint i = 0; i < sucessfullyDeposited.length; i++) 
832:        {
833:            depositor storage userInfo = userDepositInfo[sucessfullyDeposited[i]];
834:            uint256 userReward = userInfo.amount * amount / totalDeposited;
835:
836:            userInfo.claimableRewards += userReward;
837:        }
``` 



 --- 

<a name=[Gas-1]></a>
### [Gas-1] Mark storage variables as `constant` if they never change. - Instances: 1 

 > 
 State variables can be declared as constant or immutable. In both cases, the variables cannot be modified after the contract has been constructed. For constant variables, the value has to be fixed at compile-time, while for immutable, it can still be assigned at construction time. 
 The compiler does not reserve a storage slot for these variables, and every occurrence is inlined by the respective value. 
 Compared to regular state variables, the gas costs of constant and immutable variables are much lower. For a constant variable, the expression assigned to it is copied to all the places where it is accessed and also re-evaluated each time. This allows for local optimizations. Immutable variables are evaluated once at construction time and their value is copied to all the places in the code where they are accessed. For these values, 32 bytes are reserved, even if they would fit in fewer bytes. Due to this, constant values can sometimes be cheaper than immutable values. - Savings: ~2103 
 

 --- 

File:Contract.sol#L596
```solidity
595:    uint256 decimals = 6;
``` 



 --- 

<a name=[Gas-2]></a>
### [Gas-2] Mark storage variables as `immutable` if they never change after contract initialization. - Instances: 1 

 > 
 State variables can be declared as constant or immutable. In both cases, the variables cannot be modified after the contract has been constructed. For constant variables, the value has to be fixed at compile-time, while for immutable, it can still be assigned at construction time. 
 The compiler does not reserve a storage slot for these variables, and every occurrence is inlined by the respective value. 
 Compared to regular state variables, the gas costs of constant and immutable variables are much lower. For a constant variable, the expression assigned to it is copied to all the places where it is accessed and also re-evaluated each time. This allows for local optimizations. Immutable variables are evaluated once at construction time and their value is copied to all the places in the code where they are accessed. For these values, 32 bytes are reserved, even if they would fit in fewer bytes. Due to this, constant values can sometimes be cheaper than immutable values. 
 - Savings: ~2103 
 

 --- 

File:Contract.sol#L598
```solidity
597:    address public owner;
``` 



File:Contract.sol#L184
```solidity
183:    string private _name;
``` 



File:Contract.sol#L185
```solidity
184:    string private _symbol;
``` 



 --- 

<a name=[Gas-3]></a>
### [Gas-3] `unchecked{++i}` instead of `i++` (or use assembly when applicable) - Instances: 1 

 > 
 Use `++i` instead of `i++`. This is especially useful in for loops but this optimization can be used anywhere in your code. You can also use `unchecked{++i;}` for even more gas savings but this will not check to see if `i` overflows. For extra safety if you are worried about this, you can add a require statement after the loop checking if `i` is equal to the final incremented value. For best gas savings, use inline assembly, however this limits the functionality you can achieve. For example you cant use Solidity syntax to internally call your own contract within an assembly block and external calls must be done with the `call()` or `delegatecall()` instruction. However when applicable, inline assembly will save much more gas. - Savings: ~342 
 

 --- 

File:Contract.sol#L895
```solidity
894:        for (uint i = indexToDelete; i < newArray.length; i++) {
``` 



File:Contract.sol#L712
```solidity
711:        for (uint i = 0; i < awaitingApproval.length; i++) 
``` 



File:Contract.sol#L892
```solidity
891:        for (uint i = 0; i < indexToDelete; i++) {
``` 



File:Contract.sol#L832
```solidity
831:        for (uint i = 0; i < sucessfullyDeposited.length; i++) 
``` 



File:Contract.sol#L878
```solidity
877:        for (uint i = 0; i < addressArray.length; i++) {
``` 



File:Contract.sol#L740
```solidity
739:        for (uint i = 0; i < withdrawRequests.length; i++) 
``` 



File:Contract.sol#L667
```solidity
666:        for (uint i = 0; i < withdrawRequests.length; i++) 
``` 



 --- 

<a name=[Gas-4]></a>
### [Gas-4] Cache Storage Variables in Memory - Instances: 1 

 > 
  - Savings: ~0 
 

 --- 

File:Contract.sol#L370
```solidity
369:            _balances[from] = fromBalance - amount;
``` 



File:Contract.sol#L373
```solidity
372:            _balances[to] += amount;
``` 



File:Contract.sol#L370
```solidity
369:            _balances[from] = fromBalance - amount;
``` 



File:Contract.sol#L373
```solidity
372:            _balances[to] += amount;
``` 



File:Contract.sol#L424
```solidity
423:            _balances[account] = accountBalance - amount;
``` 



File:Contract.sol#L424
```solidity
423:            _balances[account] = accountBalance - amount;
``` 



File:Contract.sol#L568
```solidity
567:        _status = _ENTERED;
``` 



File:Contract.sol#L669
```solidity
668:            depositor memory user = userDepositInfo[withdrawRequests[i]];
``` 



File:Contract.sol#L685
```solidity
684:        require(usdcAddress.transfer(adminWallet, usdcAddress.balanceOf(address(this))));
``` 



File:Contract.sol#L685
```solidity
684:        require(usdcAddress.transfer(adminWallet, usdcAddress.balanceOf(address(this))));
``` 



File:Contract.sol#L703
```solidity
702:        if(findAddressIndex(awaitingApproval, msg.sender) > awaitingApproval.length){
``` 



File:Contract.sol#L704
```solidity
703:            awaitingApproval.push(msg.sender);
``` 



File:Contract.sol#L708
```solidity
707:        require(usdcAddress.transferFrom(msg.sender, adminWallet, amount));
``` 



File:Contract.sol#L703
```solidity
702:        if(findAddressIndex(awaitingApproval, msg.sender) > awaitingApproval.length){
``` 



File:Contract.sol#L704
```solidity
703:            awaitingApproval.push(msg.sender);
``` 



File:Contract.sol#L708
```solidity
707:        require(usdcAddress.transferFrom(msg.sender, adminWallet, amount));
``` 



File:Contract.sol#L715
```solidity
714:            if(findAddressIndex(sucessfullyDeposited, awaitingApproval[i]) > sucessfullyDeposited.length){
``` 



File:Contract.sol#L715
```solidity
714:            if(findAddressIndex(sucessfullyDeposited, awaitingApproval[i]) > sucessfullyDeposited.length){
``` 



File:Contract.sol#L716
```solidity
715:                sucessfullyDeposited.push(awaitingApproval[i]);
``` 



File:Contract.sol#L716
```solidity
715:                sucessfullyDeposited.push(awaitingApproval[i]);
``` 



File:Contract.sol#L733
```solidity
732:        delete awaitingApproval;
``` 



File:Contract.sol#L715
```solidity
714:            if(findAddressIndex(sucessfullyDeposited, awaitingApproval[i]) > sucessfullyDeposited.length){
``` 



File:Contract.sol#L715
```solidity
714:            if(findAddressIndex(sucessfullyDeposited, awaitingApproval[i]) > sucessfullyDeposited.length){
``` 



File:Contract.sol#L716
```solidity
715:                sucessfullyDeposited.push(awaitingApproval[i]);
``` 



File:Contract.sol#L716
```solidity
715:                sucessfullyDeposited.push(awaitingApproval[i]);
``` 



File:Contract.sol#L733
```solidity
732:        delete awaitingApproval;
``` 



File:Contract.sol#L753
```solidity
752:                    awaitingApproval = deleteAddressFromArray(awaitingApproval, withdrawRequests[i]);
``` 



File:Contract.sol#L753
```solidity
752:                    awaitingApproval = deleteAddressFromArray(awaitingApproval, withdrawRequests[i]);
``` 



File:Contract.sol#L756
```solidity
755:                    totalPending -= withdrawAmount;
``` 



File:Contract.sol#L777
```solidity
776:                sucessfullyDeposited = deleteAddressFromArray(sucessfullyDeposited, withdrawRequests[i]);
``` 



File:Contract.sol#L777
```solidity
776:                sucessfullyDeposited = deleteAddressFromArray(sucessfullyDeposited, withdrawRequests[i]);
``` 



File:Contract.sol#L781
```solidity
780:        delete withdrawRequests;
``` 



File:Contract.sol#L753
```solidity
752:                    awaitingApproval = deleteAddressFromArray(awaitingApproval, withdrawRequests[i]);
``` 



File:Contract.sol#L753
```solidity
752:                    awaitingApproval = deleteAddressFromArray(awaitingApproval, withdrawRequests[i]);
``` 



File:Contract.sol#L756
```solidity
755:                    totalPending -= withdrawAmount;
``` 



File:Contract.sol#L777
```solidity
776:                sucessfullyDeposited = deleteAddressFromArray(sucessfullyDeposited, withdrawRequests[i]);
``` 



File:Contract.sol#L777
```solidity
776:                sucessfullyDeposited = deleteAddressFromArray(sucessfullyDeposited, withdrawRequests[i]);
``` 



File:Contract.sol#L781
```solidity
780:        delete withdrawRequests;
``` 



File:Contract.sol#L799
```solidity
798:        if(findAddressIndex(withdrawRequests, msg.sender) > withdrawRequests.length){
``` 



File:Contract.sol#L800
```solidity
799:            withdrawRequests.push(msg.sender);
``` 



File:Contract.sol#L799
```solidity
798:        if(findAddressIndex(withdrawRequests, msg.sender) > withdrawRequests.length){
``` 



File:Contract.sol#L800
```solidity
799:            withdrawRequests.push(msg.sender);
``` 



File:Contract.sol#L807
```solidity
806:        require(findAddressIndex(withdrawRequests, msg.sender) <= withdrawRequests.length);
``` 



File:Contract.sol#L813
```solidity
812:        withdrawRequests = deleteAddressFromArray(withdrawRequests, msg.sender);
``` 



File:Contract.sol#L813
```solidity
812:        withdrawRequests = deleteAddressFromArray(withdrawRequests, msg.sender);
``` 



File:Contract.sol#L807
```solidity
806:        require(findAddressIndex(withdrawRequests, msg.sender) <= withdrawRequests.length);
``` 



File:Contract.sol#L813
```solidity
812:        withdrawRequests = deleteAddressFromArray(withdrawRequests, msg.sender);
``` 



File:Contract.sol#L813
```solidity
812:        withdrawRequests = deleteAddressFromArray(withdrawRequests, msg.sender);
``` 



File:Contract.sol#L827
```solidity
826:        require(usdcAddress.transfer(msg.sender, amountToSend));
``` 



File:Contract.sol#L827
```solidity
826:        require(usdcAddress.transfer(msg.sender, amountToSend));
``` 



File:Contract.sol#L834
```solidity
833:            depositor storage userInfo = userDepositInfo[sucessfullyDeposited[i]];
``` 



File:Contract.sol#L840
```solidity
839:        history.push(rewardHistory(totalDeposited, amount, block.timestamp - lastEpochTime, adminBalance));
``` 



File:Contract.sol#L834
```solidity
833:            depositor storage userInfo = userDepositInfo[sucessfullyDeposited[i]];
``` 



File:Contract.sol#L840
```solidity
839:        history.push(rewardHistory(totalDeposited, amount, block.timestamp - lastEpochTime, adminBalance));
``` 



File:Contract.sol#L854
```solidity
853:        require(usdcAddress.transfer(msg.sender, userReward));
``` 



File:Contract.sol#L854
```solidity
853:        require(usdcAddress.transfer(msg.sender, userReward));
``` 



File:Contract.sol#L869
```solidity
868:        if(findAddressIndex(awaitingApproval, msg.sender) > awaitingApproval.length){
``` 



File:Contract.sol#L870
```solidity
869:            awaitingApproval.push(msg.sender);
``` 



File:Contract.sol#L874
```solidity
873:        require(usdcAddress.transfer(adminWallet, userReward));
``` 



File:Contract.sol#L869
```solidity
868:        if(findAddressIndex(awaitingApproval, msg.sender) > awaitingApproval.length){
``` 



File:Contract.sol#L870
```solidity
869:            awaitingApproval.push(msg.sender);
``` 



File:Contract.sol#L874
```solidity
873:        require(usdcAddress.transfer(adminWallet, userReward));
``` 



 --- 

<a name=[Gas-5]></a>
### [Gas-5] Use assembly to check for address(0) - Instances: 1 

 > 
  - Savings: ~6 
 

 --- 

File:Contract.sol#L362
```solidity
361:        require(from != address(0), "ERC20: transfer from the zero address");
``` 



File:Contract.sol#L363
```solidity
362:        require(to != address(0), "ERC20: transfer to the zero address");
``` 



File:Contract.sol#L391
```solidity
390:        require(account != address(0), "ERC20: mint to the zero address");
``` 



File:Contract.sol#L417
```solidity
416:        require(account != address(0), "ERC20: burn from the zero address");
``` 



File:Contract.sol#L448
```solidity
447:        require(owner != address(0), "ERC20: approve from the zero address");
``` 



File:Contract.sol#L449
```solidity
448:        require(spender != address(0), "ERC20: approve to the zero address");
``` 



File:Contract.sol#L636
```solidity
635:        require(_owner != address(0), "Owner address cannot be zero");
``` 



File:Contract.sol#L637
```solidity
636:        require(_adminWallet != address(0), "Admin wallet cannot be zero");
``` 



 --- 

<a name=[Gas-6]></a>
### [Gas-6] Optimal Comparison - Instances: 1 

 > 
 When comparing integers, it is cheaper to use strict `>` & `<` operators over `>=` & `<=` operators, even if you must increment or decrement one of the operands. 
 Note: before using this technique, it's important to consider whether incrementing/decrementing one of the operators could result in an over/underflow. This optimization is applicable when the optimizer is turned off. - Savings: ~3 
 

 --- 

File:Contract.sol#L339
```solidity
338:        require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
``` 



File:Contract.sol#L368
```solidity
367:        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
``` 



File:Contract.sol#L422
```solidity
421:        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
``` 



File:Contract.sol#L466
```solidity
465:            require(currentAllowance >= amount, "ERC20: insufficient allowance");
``` 



File:Contract.sol#L707
```solidity
706:        require(usdcAddress.balanceOf(msg.sender) >= amount);
``` 



File:Contract.sol#L794
```solidity
793:        require(userInfo.amount + userInfo.pendingAmount >= userInfo.withrawalRequestAmount + amount);
``` 



File:Contract.sol#L807
```solidity
806:        require(findAddressIndex(withdrawRequests, msg.sender) <= withdrawRequests.length);
``` 



File:Contract.sol#L826
```solidity
825:        require(usdcAddress.balanceOf(address(this)) >= amountToSend);
``` 



File:Contract.sol#L853
```solidity
852:        require(usdcAddress.balanceOf(address(this)) >= userReward);
``` 



File:Contract.sol#L873
```solidity
872:        require(usdcAddress.balanceOf(address(this)) >= userReward);
``` 



 --- 

<a name=[Gas-7]></a>
### [Gas-7] Use `calldata` instead of `memory` for function arguments that do not get mutated. - Instances: 1 

 > 
 Mark data types as `calldata` instead of `memory` where possible. This makes it so that the data is not automatically loaded into memory. If the data passed into the function does not need to be changed (like updating values in an array), it can be passed in as `calldata`. The one exception to this is if the argument must later be passed into another function that takes an argument that specifies `memory` storage. - Savings: ~1716 
 

 --- 

File:Contract.sol#L877
```solidity
876:    function findAddressIndex(address[] memory addressArray, address addressToFind) internal pure returns (uint) {
``` 



File:Contract.sol#L886
```solidity
885:    function deleteAddressFromArray(address[] memory addressArray, address addressToDelete) internal pure returns (address[] memory) {
``` 



 --- 

<a name=[Gas-8]></a>
### [Gas-8] Use assembly for math (add, sub, mul, div) - Instances: 1 

 > 
 Use assembly for math instead of Solidity. You can check for overflow/underflow in assembly to ensure safety. If using Solidity versions < 0.8.0 and you are using Safemath, you can gain significant gas savings by using assembly to calculate values and checking for overflow/underflow. - Savings: ~60 
 

 --- 

File:Contract.sol#L318
```solidity
317:        _approve(owner, spender, allowance(owner, spender) + addedValue);
``` 



File:Contract.sol#L341
```solidity
340:            _approve(owner, spender, currentAllowance - subtractedValue);
``` 



File:Contract.sol#L370
```solidity
369:            _balances[from] = fromBalance - amount;
``` 



File:Contract.sol#L424
```solidity
423:            _balances[account] = accountBalance - amount;
``` 



File:Contract.sol#L468
```solidity
467:                _approve(owner, spender, currentAllowance - amount);
``` 



File:Contract.sol#L794
```solidity
793:        require(userInfo.amount + userInfo.pendingAmount >= userInfo.withrawalRequestAmount + amount);
``` 



File:Contract.sol#L794
```solidity
793:        require(userInfo.amount + userInfo.pendingAmount >= userInfo.withrawalRequestAmount + amount);
``` 



File:Contract.sol#L835
```solidity
834:            uint256 userReward = userInfo.amount * amount / totalDeposited;
``` 



File:Contract.sol#L835
```solidity
834:            uint256 userReward = userInfo.amount * amount / totalDeposited;
``` 



File:Contract.sol#L840
```solidity
839:        history.push(rewardHistory(totalDeposited, amount, block.timestamp - lastEpochTime, adminBalance));
``` 



File:Contract.sol#L887
```solidity
886:        address[] memory newArray = new address[](addressArray.length - 1);
``` 



File:Contract.sol#L896
```solidity
895:            newArray[i] = addressArray[i + 1];
``` 



 --- 

<a name=[Gas-9]></a>
### [Gas-9] Use assembly to write storage values - Instances: 1 

 > 
 You can save a fair amount of gas by using assembly to write storage values. - Savings: ~66 
 

 --- 

File:Contract.sol#L194
```solidity
193:        _name = name_;
``` 



File:Contract.sol#L195
```solidity
194:        _symbol = symbol_;
``` 



File:Contract.sol#L547
```solidity
546:        _status = _NOT_ENTERED;
``` 



File:Contract.sol#L568
```solidity
567:        _status = _ENTERED;
``` 



File:Contract.sol#L574
```solidity
573:        _status = _NOT_ENTERED;
``` 



File:Contract.sol#L639
```solidity
638:        lastEpochTime = block.timestamp;
``` 



File:Contract.sol#L640
```solidity
639:        owner = _owner;
``` 



File:Contract.sol#L641
```solidity
640:        adminWallet = _adminWallet;
``` 



File:Contract.sol#L681
```solidity
680:        adminWallet = newWallet;
``` 



File:Contract.sol#L729
```solidity
728:        totalPending = 0;
``` 



File:Contract.sol#L730
```solidity
729:        lastEpochTime = block.timestamp;
``` 



 --- 

<a name=[Gas-10]></a>
### [Gas-10] Event is not properly indexed. - Instances: 1 

 > 
 When possible, always include a minimum of 3 indexed event topics to save gas - Savings: ~0 
 

 --- 

File:Contract.sol#L18
```solidity
17:    event Transfer(address indexed from, address indexed to, uint256 value);
``` 



File:Contract.sol#L24
```solidity
23:    event Approval(address indexed owner, address indexed spender, uint256 value);
``` 



 --- 

<a name=[Gas-11]></a>
### [Gas-11] Mark functions as payable (with discretion) - Instances: 1 

 > 
 You can mark public or external functions as payable to save gas. Functions that are not payable have additional logic to check if there was a value sent with a call, however, making a function payable eliminates this check. This optimization should be carefully considered due to potentially unwanted behavior when a function does not need to accept ether. - Savings: ~24 
 

 --- 

File:Contract.sol#L201
```solidity
200:    function name() public view virtual override returns (string memory) {
``` 



File:Contract.sol#L209
```solidity
208:    function symbol() public view virtual override returns (string memory) {
``` 



File:Contract.sol#L226
```solidity
225:    function decimals() public view virtual override returns (uint8) {
``` 



File:Contract.sol#L233
```solidity
232:    function totalSupply() public view virtual override returns (uint256) {
``` 



File:Contract.sol#L240
```solidity
239:    function balanceOf(address account) public view virtual override returns (uint256) {
``` 



File:Contract.sol#L252
```solidity
251:    function transfer(address to, uint256 amount) public virtual override returns (bool) {
``` 



File:Contract.sol#L261
```solidity
260:    function allowance(address owner, address spender) public view virtual override returns (uint256) {
``` 



File:Contract.sol#L275
```solidity
274:    function approve(address spender, uint256 amount) public virtual override returns (bool) {
``` 



File:Contract.sol#L297
```solidity
296:    function transferFrom(address from, address to, uint256 amount) public virtual override returns (bool) {
``` 



File:Contract.sol#L316
```solidity
315:    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
``` 



File:Contract.sol#L336
```solidity
335:    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
``` 



File:Contract.sol#L649
```solidity
648:    function getAwaitingApproval() external view returns (address[] memory){
``` 



File:Contract.sol#L653
```solidity
652:    function getWithdrawRequests() external view returns (address[] memory){
``` 



File:Contract.sol#L657
```solidity
656:    function getSuccessfullyDeposited() external view returns (address[] memory){
``` 



File:Contract.sol#L661
```solidity
660:    function getHistory() external view returns (rewardHistory[] memory){
``` 



File:Contract.sol#L665
```solidity
664:    function getWithdrawRequestsAmount() external view returns(uint256) {
``` 



File:Contract.sol#L676
```solidity
675:    function getUserDeposit(address addr) external view returns (depositor memory) {
``` 



File:Contract.sol#L680
```solidity
679:    function changeAdminWallet(address newWallet) external onlyOwner {
``` 



File:Contract.sol#L684
```solidity
683:    function removeTokens() external onlyOwner {
``` 



File:Contract.sol#L688
```solidity
687:    function deposit(uint256 amount) external nonReentrant{
``` 



File:Contract.sol#L711
```solidity
710:    function startNewCycle() external onlyOwner {
``` 



File:Contract.sol#L736
```solidity
735:    function approveWithdrawRequests() external onlyOwner {
``` 



File:Contract.sol#L787
```solidity
786:    function requestWithdraw(uint256 amount) external nonReentrant{
``` 



File:Contract.sol#L804
```solidity
803:    function cancelRequestWithdraw() external nonReentrant{
``` 



File:Contract.sol#L816
```solidity
815:    function withdraw() external nonReentrant{
``` 



File:Contract.sol#L830
```solidity
829:    function distributeRewards(uint256 amount, uint256 adminBalance) external onlyOwner {
``` 



File:Contract.sol#L845
```solidity
844:    function claimRewards() external nonReentrant{
``` 



File:Contract.sol#L857
```solidity
856:    function reDeposit() external nonReentrant{
``` 



 --- 

<a name=[Gas-12]></a>
### [Gas-12] Cache array length during for loop definition. - Instances: 1 

 > 
 A typical for loop definition may look like: `for (uint256 i; i < arr.length; i++){}`. Instead of using `array.length`, cache the array length before the loop, and use the cached value to safe gas. This will avoid an `MLOAD` every loop for arrays stored in memory and an `SLOAD` for arrays stored in storage. This can have significant gas savings for arrays with a large length, especially if the array is stored in storage. - Savings: ~22 
 

 --- 

File:Contract.sol#L667
```solidity
666:        for (uint i = 0; i < withdrawRequests.length; i++) 
``` 



File:Contract.sol#L712
```solidity
711:        for (uint i = 0; i < awaitingApproval.length; i++) 
``` 



File:Contract.sol#L740
```solidity
739:        for (uint i = 0; i < withdrawRequests.length; i++) 
``` 



File:Contract.sol#L832
```solidity
831:        for (uint i = 0; i < sucessfullyDeposited.length; i++) 
``` 



File:Contract.sol#L878
```solidity
877:        for (uint i = 0; i < addressArray.length; i++) {
``` 



File:Contract.sol#L895
```solidity
894:        for (uint i = indexToDelete; i < newArray.length; i++) {
``` 



 --- 

<a name=[Gas-13]></a>
### [Gas-13] Short Revert Strings - Instances: 1 

 > 
 Keeping revert strings under 32-bytes prevents the string from being stored in more than one memory slot. - Savings: ~3 
 

 --- 

File:Contract.sol#L339
```solidity
338:        require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
``` 



File:Contract.sol#L362
```solidity
361:        require(from != address(0), "ERC20: transfer from the zero address");
``` 



File:Contract.sol#L363
```solidity
362:        require(to != address(0), "ERC20: transfer to the zero address");
``` 



File:Contract.sol#L368
```solidity
367:        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
``` 



File:Contract.sol#L417
```solidity
416:        require(account != address(0), "ERC20: burn from the zero address");
``` 



File:Contract.sol#L422
```solidity
421:        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
``` 



File:Contract.sol#L448
```solidity
447:        require(owner != address(0), "ERC20: approve from the zero address");
``` 



File:Contract.sol#L449
```solidity
448:        require(spender != address(0), "ERC20: approve to the zero address");
``` 



File:Contract.sol#L784
```solidity
783:        require(sent, "Failed to transfer withdraw amount");
``` 



File:Contract.sol#L842
```solidity
841:        require(sent, "Failed to transfer funds from admin wallet");
``` 



 --- 



## Quality Assurance - Total: 121 

<a name=[NonCritical-0]></a>
### [NonCritical-0] Constructor should be listed before any other function - Instances: 1 

 > Consider changing the order of the functions so that the constructor is listed first 

 --- 

File:Contract.sol#L193
```solidity
192:    constructor(string memory name_, string memory symbol_) {
``` 



 --- 

<a name=[NonCritical-1]></a>
### [NonCritical-1] Constructor should check that all parameters are not 0 - Instances: 2 

 > Consider adding a require statement to check that all parameters are not 0 in the constructor 

 --- 

File:Contract.sol#L193
```solidity
192:    constructor(string memory name_, string memory symbol_) {
``` 



File:Contract.sol#L193
```solidity
192:    constructor(string memory name_, string memory symbol_) {
``` 



 --- 

<a name=[NonCritical-2]></a>
### [NonCritical-2] Contract names should be in PascalCase - Instances: 1 

 > Ensure that contract definitions are declared using PascalCase 

 --- 

File:Contract.sol#L593
```solidity
``` 



 --- 

<a name=[NonCritical-3]></a>
### [NonCritical-3] Large contracts with many external functions should inherit an interface - Instances: 1 

 > Consider inheriting the interface to ensure the interface matches the contract spec 

 --- 

File:Contract.sol#L593
```solidity
592:contract numericalVault1 is ReentrancyGuard{
``` 



 --- 

<a name=[NonCritical-4]></a>
### [NonCritical-4] Storage variables should not have implicit visibility - Instances: 7 

 > Consider explicitly specifying the visibility of storage variables for readability 

 --- 

File:Contract.sol#L595
```solidity
594:    ERC20 usdcAddress = ERC20(0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913);
``` 



File:Contract.sol#L596
```solidity
595:    uint256 decimals = 6;
``` 



File:Contract.sol#L613
```solidity
612:    rewardHistory[] history;
``` 



File:Contract.sol#L615
```solidity
614:    address[] sucessfullyDeposited;
``` 



File:Contract.sol#L616
```solidity
615:    address[] awaitingApproval;
``` 



File:Contract.sol#L617
```solidity
616:    address[] withdrawRequests;
``` 



File:Contract.sol#L633
```solidity
632:    mapping (address => depositor) userDepositInfo;
``` 



 --- 

<a name=[NonCritical-5]></a>
### [NonCritical-5] Function names should be in camelCase - Instances: 18 

 > Ensure that function definitions are declared using camelCase 

 --- 

File:Contract.sol#L43
```solidity
42:    function transfer(address to, uint256 amount) external returns (bool);
``` 



File:Contract.sol#L52
```solidity
51:    function allowance(address owner, address spender) external view returns (uint256);
``` 



File:Contract.sol#L68
```solidity
67:    function approve(address spender, uint256 amount) external returns (bool);
``` 



File:Contract.sol#L99
```solidity
98:    function name() external view returns (string memory);
``` 



File:Contract.sol#L104
```solidity
103:    function symbol() external view returns (string memory);
``` 



File:Contract.sol#L109
```solidity
108:    function decimals() external view returns (uint8);
``` 



File:Contract.sol#L201
```solidity
200:    function name() public view virtual override returns (string memory) {
``` 



File:Contract.sol#L209
```solidity
208:    function symbol() public view virtual override returns (string memory) {
``` 



File:Contract.sol#L226
```solidity
225:    function decimals() public view virtual override returns (uint8) {
``` 



File:Contract.sol#L252
```solidity
251:    function transfer(address to, uint256 amount) public virtual override returns (bool) {
``` 



File:Contract.sol#L261
```solidity
260:    function allowance(address owner, address spender) public view virtual override returns (uint256) {
``` 



File:Contract.sol#L275
```solidity
274:    function approve(address spender, uint256 amount) public virtual override returns (bool) {
``` 



File:Contract.sol#L361
```solidity
360:    function _transfer(address from, address to, uint256 amount) internal virtual {
``` 



File:Contract.sol#L390
```solidity
389:    function _mint(address account, uint256 amount) internal virtual {
``` 



File:Contract.sol#L416
```solidity
415:    function _burn(address account, uint256 amount) internal virtual {
``` 



File:Contract.sol#L447
```solidity
446:    function _approve(address owner, address spender, uint256 amount) internal virtual {
``` 



File:Contract.sol#L688
```solidity
687:    function deposit(uint256 amount) external nonReentrant{
``` 



File:Contract.sol#L816
```solidity
815:    function withdraw() external nonReentrant{
``` 



 --- 

<a name=[NonCritical-6]></a>
### [NonCritical-6] Require/Revert statements should be consistent across the codebase - Instances: 2 

 > Consider using require/revert statements consistently across the codebase 

 --- 

File:Contract.sol#L541
```solidity
540:    uint256 private constant _NOT_ENTERED = 1;
``` 



File:Contract.sol#L542
```solidity
541:    uint256 private constant _ENTERED = 2;
``` 



 --- 

<a name=[NonCritical-7]></a>
### [NonCritical-7] Only define one contract per file - Instances: 2 

 > It is best practice to only define one contract per file. 

 --- 

File:Contract.sol#L177
```solidity
176:contract ERC20 is Context, IERC20, IERC20Metadata {
177:    mapping(address => uint256) private _balances;
178:
179:    mapping(address => mapping(address => uint256)) private _allowances;
180:
181:    uint256 private _totalSupply;
182:
183:    string private _name;
184:    string private _symbol;
185:
186:    /**
187:     * @dev Sets the values for {name} and {symbol}.
188:     *
189:     * All two of these values are immutable: they can only be set once during
190:     * construction.
191:     */
192:    constructor(string memory name_, string memory symbol_) {
193:        _name = name_;
194:        _symbol = symbol_;
195:    }
196:
197:    /**
198:     * @dev Returns the name of the token.
199:     */
200:    function name() public view virtual override returns (string memory) {
201:        return _name;
202:    }
203:
204:    /**
205:     * @dev Returns the symbol of the token, usually a shorter version of the
206:     * name.
207:     */
208:    function symbol() public view virtual override returns (string memory) {
209:        return _symbol;
210:    }
211:
212:    /**
213:     * @dev Returns the number of decimals used to get its user representation.
214:     * For example, if `decimals` equals `2`, a balance of `505` tokens should
215:     * be displayed to a user as `5.05` (`505 / 10 ** 2`).
216:     *
217:     * Tokens usually opt for a value of 18, imitating the relationship between
218:     * Ether and Wei. This is the default value returned by this function, unless
219:     * it's overridden.
220:     *
221:     * NOTE: This information is only used for _display_ purposes: it in
222:     * no way affects any of the arithmetic of the contract, including
223:     * {IERC20-balanceOf} and {IERC20-transfer}.
224:     */
225:    function decimals() public view virtual override returns (uint8) {
226:        return 18;
227:    }
228:
229:    /**
230:     * @dev See {IERC20-totalSupply}.
231:     */
232:    function totalSupply() public view virtual override returns (uint256) {
233:        return _totalSupply;
234:    }
235:
236:    /**
237:     * @dev See {IERC20-balanceOf}.
238:     */
239:    function balanceOf(address account) public view virtual override returns (uint256) {
240:        return _balances[account];
241:    }
242:
243:    /**
244:     * @dev See {IERC20-transfer}.
245:     *
246:     * Requirements:
247:     *
248:     * - `to` cannot be the zero address.
249:     * - the caller must have a balance of at least `amount`.
250:     */
251:    function transfer(address to, uint256 amount) public virtual override returns (bool) {
252:        address owner = _msgSender();
253:        _transfer(owner, to, amount);
254:        return true;
255:    }
256:
257:    /**
258:     * @dev See {IERC20-allowance}.
259:     */
260:    function allowance(address owner, address spender) public view virtual override returns (uint256) {
261:        return _allowances[owner][spender];
262:    }
263:
264:    /**
265:     * @dev See {IERC20-approve}.
266:     *
267:     * NOTE: If `amount` is the maximum `uint256`, the allowance is not updated on
268:     * `transferFrom`. This is semantically equivalent to an infinite approval.
269:     *
270:     * Requirements:
271:     *
272:     * - `spender` cannot be the zero address.
273:     */
274:    function approve(address spender, uint256 amount) public virtual override returns (bool) {
275:        address owner = _msgSender();
276:        _approve(owner, spender, amount);
277:        return true;
278:    }
279:
280:    /**
281:     * @dev See {IERC20-transferFrom}.
282:     *
283:     * Emits an {Approval} event indicating the updated allowance. This is not
284:     * required by the EIP. See the note at the beginning of {ERC20}.
285:     *
286:     * NOTE: Does not update the allowance if the current allowance
287:     * is the maximum `uint256`.
288:     *
289:     * Requirements:
290:     *
291:     * - `from` and `to` cannot be the zero address.
292:     * - `from` must have a balance of at least `amount`.
293:     * - the caller must have allowance for ``from``'s tokens of at least
294:     * `amount`.
295:     */
296:    function transferFrom(address from, address to, uint256 amount) public virtual override returns (bool) {
297:        address spender = _msgSender();
298:        _spendAllowance(from, spender, amount);
299:        _transfer(from, to, amount);
300:        return true;
301:    }
302:
303:    /**
304:     * @dev Atomically increases the allowance granted to `spender` by the caller.
305:     *
306:     * This is an alternative to {approve} that can be used as a mitigation for
307:     * problems described in {IERC20-approve}.
308:     *
309:     * Emits an {Approval} event indicating the updated allowance.
310:     *
311:     * Requirements:
312:     *
313:     * - `spender` cannot be the zero address.
314:     */
315:    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
316:        address owner = _msgSender();
317:        _approve(owner, spender, allowance(owner, spender) + addedValue);
318:        return true;
319:    }
320:
321:    /**
322:     * @dev Atomically decreases the allowance granted to `spender` by the caller.
323:     *
324:     * This is an alternative to {approve} that can be used as a mitigation for
325:     * problems described in {IERC20-approve}.
326:     *
327:     * Emits an {Approval} event indicating the updated allowance.
328:     *
329:     * Requirements:
330:     *
331:     * - `spender` cannot be the zero address.
332:     * - `spender` must have allowance for the caller of at least
333:     * `subtractedValue`.
334:     */
335:    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
336:        address owner = _msgSender();
337:        uint256 currentAllowance = allowance(owner, spender);
338:        require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
339:        unchecked {
340:            _approve(owner, spender, currentAllowance - subtractedValue);
341:        }
342:
343:        return true;
344:    }
345:
346:    /**
347:     * @dev Moves `amount` of tokens from `from` to `to`.
348:     *
349:     * This internal function is equivalent to {transfer}, and can be used to
350:     * e.g. implement automatic token fees, slashing mechanisms, etc.
351:     *
352:     * Emits a {Transfer} event.
353:     *
354:     * Requirements:
355:     *
356:     * - `from` cannot be the zero address.
357:     * - `to` cannot be the zero address.
358:     * - `from` must have a balance of at least `amount`.
359:     */
360:    function _transfer(address from, address to, uint256 amount) internal virtual {
361:        require(from != address(0), "ERC20: transfer from the zero address");
362:        require(to != address(0), "ERC20: transfer to the zero address");
363:
364:        _beforeTokenTransfer(from, to, amount);
365:
366:        uint256 fromBalance = _balances[from];
367:        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
368:        unchecked {
369:            _balances[from] = fromBalance - amount;
370:            // Overflow not possible: the sum of all balances is capped by totalSupply, and the sum is preserved by
371:            // decrementing then incrementing.
372:            _balances[to] += amount;
373:        }
374:
375:        emit Transfer(from, to, amount);
376:
377:        _afterTokenTransfer(from, to, amount);
378:    }
379:
380:    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
381:     * the total supply.
382:     *
383:     * Emits a {Transfer} event with `from` set to the zero address.
384:     *
385:     * Requirements:
386:     *
387:     * - `account` cannot be the zero address.
388:     */
389:    function _mint(address account, uint256 amount) internal virtual {
390:        require(account != address(0), "ERC20: mint to the zero address");
391:
392:        _beforeTokenTransfer(address(0), account, amount);
393:
394:        _totalSupply += amount;
395:        unchecked {
396:            // Overflow not possible: balance + amount is at most totalSupply + amount, which is checked above.
397:            _balances[account] += amount;
398:        }
399:        emit Transfer(address(0), account, amount);
400:
401:        _afterTokenTransfer(address(0), account, amount);
402:    }
403:
404:    /**
405:     * @dev Destroys `amount` tokens from `account`, reducing the
406:     * total supply.
407:     *
408:     * Emits a {Transfer} event with `to` set to the zero address.
409:     *
410:     * Requirements:
411:     *
412:     * - `account` cannot be the zero address.
413:     * - `account` must have at least `amount` tokens.
414:     */
415:    function _burn(address account, uint256 amount) internal virtual {
416:        require(account != address(0), "ERC20: burn from the zero address");
417:
418:        _beforeTokenTransfer(account, address(0), amount);
419:
420:        uint256 accountBalance = _balances[account];
421:        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
422:        unchecked {
423:            _balances[account] = accountBalance - amount;
424:            // Overflow not possible: amount <= accountBalance <= totalSupply.
425:            _totalSupply -= amount;
426:        }
427:
428:        emit Transfer(account, address(0), amount);
429:
430:        _afterTokenTransfer(account, address(0), amount);
431:    }
432:
433:    /**
434:     * @dev Sets `amount` as the allowance of `spender` over the `owner` s tokens.
435:     *
436:     * This internal function is equivalent to `approve`, and can be used to
437:     * e.g. set automatic allowances for certain subsystems, etc.
438:     *
439:     * Emits an {Approval} event.
440:     *
441:     * Requirements:
442:     *
443:     * - `owner` cannot be the zero address.
444:     * - `spender` cannot be the zero address.
445:     */
446:    function _approve(address owner, address spender, uint256 amount) internal virtual {
447:        require(owner != address(0), "ERC20: approve from the zero address");
448:        require(spender != address(0), "ERC20: approve to the zero address");
449:
450:        _allowances[owner][spender] = amount;
451:        emit Approval(owner, spender, amount);
452:    }
453:
454:    /**
455:     * @dev Updates `owner` s allowance for `spender` based on spent `amount`.
456:     *
457:     * Does not update the allowance amount in case of infinite allowance.
458:     * Revert if not enough allowance is available.
459:     *
460:     * Might emit an {Approval} event.
461:     */
462:    function _spendAllowance(address owner, address spender, uint256 amount) internal virtual {
463:        uint256 currentAllowance = allowance(owner, spender);
464:        if (currentAllowance != type(uint256).max) {
465:            require(currentAllowance >= amount, "ERC20: insufficient allowance");
466:            unchecked {
467:                _approve(owner, spender, currentAllowance - amount);
468:            }
469:        }
470:    }
471:
472:    /**
473:     * @dev Hook that is called before any transfer of tokens. This includes
474:     * minting and burning.
475:     *
476:     * Calling conditions:
477:     *
478:     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
479:     * will be transferred to `to`.
480:     * - when `from` is zero, `amount` tokens will be minted for `to`.
481:     * - when `to` is zero, `amount` of ``from``'s tokens will be burned.
482:     * - `from` and `to` are never both zero.
483:     *
484:     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
485:     */
486:    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual {}
487:
488:    /**
489:     * @dev Hook that is called after any transfer of tokens. This includes
490:     * minting and burning.
491:     *
492:     * Calling conditions:
493:     *
494:     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
495:     * has been transferred to `to`.
496:     * - when `from` is zero, `amount` tokens have been minted for `to`.
497:     * - when `to` is zero, `amount` of ``from``'s tokens have been burned.
498:     * - `from` and `to` are never both zero.
499:     *
500:     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
501:     */
502:    function _afterTokenTransfer(address from, address to, uint256 amount) internal virtual {}
503:}
``` 



File:Contract.sol#L593
```solidity
``` 



 --- 

<a name=[NonCritical-8]></a>
### [NonCritical-8] Constant and immutable variable names should be in SCREAMING_SNAKE_CASE - Instances: 2 

 > Ensure that Constant and immutable variable names are declared using SCREAMING_SNAKE_CASE 

 --- 

File:Contract.sol#L541
```solidity
540:    uint256 private constant _NOT_ENTERED = 1;
``` 



File:Contract.sol#L542
```solidity
541:    uint256 private constant _ENTERED = 2;
``` 



 --- 

<a name=[NonCritical-9]></a>
### [NonCritical-9] Consider marking public function External - Instances: 10 

 > If a public function is never called internally, it is best practice to mark it as external. 

 --- 

File:Contract.sol#L336
```solidity
335:    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
``` 



File:Contract.sol#L252
```solidity
251:    function transfer(address to, uint256 amount) public virtual override returns (bool) {
``` 



File:Contract.sol#L297
```solidity
296:    function transferFrom(address from, address to, uint256 amount) public virtual override returns (bool) {
``` 



File:Contract.sol#L316
```solidity
315:    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
``` 



File:Contract.sol#L201
```solidity
200:    function name() public view virtual override returns (string memory) {
``` 



File:Contract.sol#L233
```solidity
232:    function totalSupply() public view virtual override returns (uint256) {
``` 



File:Contract.sol#L209
```solidity
208:    function symbol() public view virtual override returns (string memory) {
``` 



File:Contract.sol#L226
```solidity
225:    function decimals() public view virtual override returns (uint8) {
``` 



File:Contract.sol#L240
```solidity
239:    function balanceOf(address account) public view virtual override returns (uint256) {
``` 



File:Contract.sol#L275
```solidity
274:    function approve(address spender, uint256 amount) public virtual override returns (bool) {
``` 



 --- 

<a name=[NonCritical-10]></a>
### [NonCritical-10] Consider adding a message with require and revert statements - Instances: 16 

 > Adding a message to accompany require statements will provide more context when a transaction fails. 

 --- 

File:Contract.sol#L645
```solidity
644:        require(msg.sender == owner);
``` 



File:Contract.sol#L685
```solidity
684:        require(usdcAddress.transfer(adminWallet, usdcAddress.balanceOf(address(this))));
``` 



File:Contract.sol#L707
```solidity
706:        require(usdcAddress.balanceOf(msg.sender) >= amount);
``` 



File:Contract.sol#L708
```solidity
707:        require(usdcAddress.transferFrom(msg.sender, adminWallet, amount));
``` 



File:Contract.sol#L791
```solidity
790:        require(userInfo.amount > 0 || userInfo.pendingAmount > 0);
``` 



File:Contract.sol#L794
```solidity
793:        require(userInfo.amount + userInfo.pendingAmount >= userInfo.withrawalRequestAmount + amount);
``` 



File:Contract.sol#L807
```solidity
806:        require(findAddressIndex(withdrawRequests, msg.sender) <= withdrawRequests.length);
``` 



File:Contract.sol#L819
```solidity
818:        require(userInfo.withdrawApproved);
``` 



File:Contract.sol#L826
```solidity
825:        require(usdcAddress.balanceOf(address(this)) >= amountToSend);
``` 



File:Contract.sol#L827
```solidity
826:        require(usdcAddress.transfer(msg.sender, amountToSend));
``` 



File:Contract.sol#L848
```solidity
847:        require(userInfo.claimableRewards > 0);
``` 



File:Contract.sol#L853
```solidity
852:        require(usdcAddress.balanceOf(address(this)) >= userReward);
``` 



File:Contract.sol#L854
```solidity
853:        require(usdcAddress.transfer(msg.sender, userReward));
``` 



File:Contract.sol#L859
```solidity
858:        require(userInfo.claimableRewards > 0);
``` 



File:Contract.sol#L873
```solidity
872:        require(usdcAddress.balanceOf(address(this)) >= userReward);
``` 



File:Contract.sol#L874
```solidity
873:        require(usdcAddress.transfer(adminWallet, userReward));
``` 



 --- 

<a name=[NonCritical-11]></a>
### [NonCritical-11] Remove any unused functions - Instances: 5 

 > Any functions not used should be removed as best practice. 

 --- 

File:Contract.sol#L130
```solidity
129:    function _msgSender() internal view virtual returns (address) {
``` 



File:Contract.sol#L134
```solidity
133:    function _msgData() internal view virtual returns (bytes calldata) {
``` 



File:Contract.sol#L390
```solidity
389:    function _mint(address account, uint256 amount) internal virtual {
``` 



File:Contract.sol#L416
```solidity
415:    function _burn(address account, uint256 amount) internal virtual {
``` 



File:Contract.sol#L581
```solidity
580:    function _reentrancyGuardEntered() internal view returns (bool) {
``` 



 --- 

<a name=[NonCritical-12]></a>
### [NonCritical-12] This variable's default value is the same as the value it is initialized with - Instances: 3 

 > This is unnecessary and will have some overhead on Gas 

 --- 

File:Contract.sol#L601
```solidity
600:    uint256 public totalDeposited = 0;
``` 



File:Contract.sol#L602
```solidity
601:    uint256 public totalPending = 0;
``` 



File:Contract.sol#L605
```solidity
604:    uint256 public currentEpoch = 0;
``` 



 --- 

<a name=[NonCritical-13]></a>
### [NonCritical-13] Function parameters should be in camelCase - Instances: 48 

 > Ensure that function parameters are declared using camelCase 

 --- 

File:Contract.sol#L34
```solidity
33:    function balanceOf(address account) external view returns (uint256);
``` 



File:Contract.sol#L43
```solidity
42:    function transfer(address to, uint256 amount) external returns (bool);
``` 



File:Contract.sol#L43
```solidity
42:    function transfer(address to, uint256 amount) external returns (bool);
``` 



File:Contract.sol#L52
```solidity
51:    function allowance(address owner, address spender) external view returns (uint256);
``` 



File:Contract.sol#L52
```solidity
51:    function allowance(address owner, address spender) external view returns (uint256);
``` 



File:Contract.sol#L68
```solidity
67:    function approve(address spender, uint256 amount) external returns (bool);
``` 



File:Contract.sol#L68
```solidity
67:    function approve(address spender, uint256 amount) external returns (bool);
``` 



File:Contract.sol#L79
```solidity
78:    function transferFrom(address from, address to, uint256 amount) external returns (bool);
``` 



File:Contract.sol#L79
```solidity
78:    function transferFrom(address from, address to, uint256 amount) external returns (bool);
``` 



File:Contract.sol#L79
```solidity
78:    function transferFrom(address from, address to, uint256 amount) external returns (bool);
``` 



File:Contract.sol#L193
```solidity
192:    constructor(string memory name_, string memory symbol_) {
``` 



File:Contract.sol#L193
```solidity
192:    constructor(string memory name_, string memory symbol_) {
``` 



File:Contract.sol#L240
```solidity
239:    function balanceOf(address account) public view virtual override returns (uint256) {
``` 



File:Contract.sol#L252
```solidity
251:    function transfer(address to, uint256 amount) public virtual override returns (bool) {
``` 



File:Contract.sol#L252
```solidity
251:    function transfer(address to, uint256 amount) public virtual override returns (bool) {
``` 



File:Contract.sol#L261
```solidity
260:    function allowance(address owner, address spender) public view virtual override returns (uint256) {
``` 



File:Contract.sol#L261
```solidity
260:    function allowance(address owner, address spender) public view virtual override returns (uint256) {
``` 



File:Contract.sol#L275
```solidity
274:    function approve(address spender, uint256 amount) public virtual override returns (bool) {
``` 



File:Contract.sol#L275
```solidity
274:    function approve(address spender, uint256 amount) public virtual override returns (bool) {
``` 



File:Contract.sol#L297
```solidity
296:    function transferFrom(address from, address to, uint256 amount) public virtual override returns (bool) {
``` 



File:Contract.sol#L297
```solidity
296:    function transferFrom(address from, address to, uint256 amount) public virtual override returns (bool) {
``` 



File:Contract.sol#L297
```solidity
296:    function transferFrom(address from, address to, uint256 amount) public virtual override returns (bool) {
``` 



File:Contract.sol#L316
```solidity
315:    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
``` 



File:Contract.sol#L336
```solidity
335:    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
``` 



File:Contract.sol#L361
```solidity
360:    function _transfer(address from, address to, uint256 amount) internal virtual {
``` 



File:Contract.sol#L361
```solidity
360:    function _transfer(address from, address to, uint256 amount) internal virtual {
``` 



File:Contract.sol#L361
```solidity
360:    function _transfer(address from, address to, uint256 amount) internal virtual {
``` 



File:Contract.sol#L390
```solidity
389:    function _mint(address account, uint256 amount) internal virtual {
``` 



File:Contract.sol#L390
```solidity
389:    function _mint(address account, uint256 amount) internal virtual {
``` 



File:Contract.sol#L416
```solidity
415:    function _burn(address account, uint256 amount) internal virtual {
``` 



File:Contract.sol#L416
```solidity
415:    function _burn(address account, uint256 amount) internal virtual {
``` 



File:Contract.sol#L447
```solidity
446:    function _approve(address owner, address spender, uint256 amount) internal virtual {
``` 



File:Contract.sol#L447
```solidity
446:    function _approve(address owner, address spender, uint256 amount) internal virtual {
``` 



File:Contract.sol#L447
```solidity
446:    function _approve(address owner, address spender, uint256 amount) internal virtual {
``` 



File:Contract.sol#L463
```solidity
462:    function _spendAllowance(address owner, address spender, uint256 amount) internal virtual {
``` 



File:Contract.sol#L463
```solidity
462:    function _spendAllowance(address owner, address spender, uint256 amount) internal virtual {
``` 



File:Contract.sol#L463
```solidity
462:    function _spendAllowance(address owner, address spender, uint256 amount) internal virtual {
``` 



File:Contract.sol#L487
```solidity
486:    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual {}
``` 



File:Contract.sol#L487
```solidity
486:    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual {}
``` 



File:Contract.sol#L487
```solidity
486:    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual {}
``` 



File:Contract.sol#L503
```solidity
502:    function _afterTokenTransfer(address from, address to, uint256 amount) internal virtual {}
``` 



File:Contract.sol#L503
```solidity
502:    function _afterTokenTransfer(address from, address to, uint256 amount) internal virtual {}
``` 



File:Contract.sol#L503
```solidity
502:    function _afterTokenTransfer(address from, address to, uint256 amount) internal virtual {}
``` 



File:Contract.sol#L635
```solidity
634:    constructor(address _owner, address _adminWallet) {
``` 



File:Contract.sol#L676
```solidity
675:    function getUserDeposit(address addr) external view returns (depositor memory) {
``` 



File:Contract.sol#L688
```solidity
687:    function deposit(uint256 amount) external nonReentrant{
``` 



File:Contract.sol#L787
```solidity
786:    function requestWithdraw(uint256 amount) external nonReentrant{
``` 



File:Contract.sol#L830
```solidity
829:    function distributeRewards(uint256 amount, uint256 adminBalance) external onlyOwner {
``` 



 --- 

<a name=[NonCritical-14]></a>
### [NonCritical-14] Consider explicitly naming mapping parameters - Instances: 3 

 > Consider explicitly naming mapping parameters for readability 

 --- 

File:Contract.sol#L178
```solidity
177:    mapping(address => uint256) private _balances;
``` 



File:Contract.sol#L180
```solidity
179:    mapping(address => mapping(address => uint256)) private _allowances;
``` 



File:Contract.sol#L633
```solidity
632:    mapping (address => depositor) userDepositInfo;
``` 



 --- 


