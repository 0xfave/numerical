/**
 *Submitted for verification at basescan.org on 2024-06-10
*/

// File: @openzeppelin/contracts/token/ERC20/IERC20.sol


// OpenZeppelin Contracts (last updated v4.9.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `from` to `to` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}

// File: @openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol


// OpenZeppelin Contracts v4.4.1 (token/ERC20/extensions/IERC20Metadata.sol)

pragma solidity ^0.8.0;


/**
 * @dev Interface for the optional metadata functions from the ERC20 standard.
 *
 * _Available since v4.1._
 */
interface IERC20Metadata is IERC20 {
    /**
     * @dev Returns the name of the token.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the symbol of the token.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the decimals places of the token.
     */
    function decimals() external view returns (uint8);
}

// File: @openzeppelin/contracts/utils/Context.sol


// OpenZeppelin Contracts v4.4.1 (utils/Context.sol)

pragma solidity ^0.8.0;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

// File: @openzeppelin/contracts/token/ERC20/ERC20.sol


// OpenZeppelin Contracts (last updated v4.9.0) (token/ERC20/ERC20.sol)

pragma solidity ^0.8.0;




/**
 * @dev Implementation of the {IERC20} interface.
 *
 * This implementation is agnostic to the way tokens are created. This means
 * that a supply mechanism has to be added in a derived contract using {_mint}.
 * For a generic mechanism see {ERC20PresetMinterPauser}.
 *
 * TIP: For a detailed writeup see our guide
 * https://forum.openzeppelin.com/t/how-to-implement-erc20-supply-mechanisms/226[How
 * to implement supply mechanisms].
 *
 * The default value of {decimals} is 18. To change this, you should override
 * this function so it returns a different value.
 *
 * We have followed general OpenZeppelin Contracts guidelines: functions revert
 * instead returning `false` on failure. This behavior is nonetheless
 * conventional and does not conflict with the expectations of ERC20
 * applications.
 *
 * Additionally, an {Approval} event is emitted on calls to {transferFrom}.
 * This allows applications to reconstruct the allowance for all accounts just
 * by listening to said events. Other implementations of the EIP may not emit
 * these events, as it isn't required by the specification.
 *
 * Finally, the non-standard {decreaseAllowance} and {increaseAllowance}
 * functions have been added to mitigate the well-known issues around setting
 * allowances. See {IERC20-approve}.
 */
contract ERC20 is Context, IERC20, IERC20Metadata {
    mapping(address => uint256) private _balances;

    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

    /**
     * @dev Sets the values for {name} and {symbol}.
     *
     * All two of these values are immutable: they can only be set once during
     * construction.
     */
    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() public view virtual override returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5.05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei. This is the default value returned by this function, unless
     * it's overridden.
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() public view virtual override returns (uint8) {
        return 18;
    }

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true;
    }

    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See {IERC20-approve}.
     *
     * NOTE: If `amount` is the maximum `uint256`, the allowance is not updated on
     * `transferFrom`. This is semantically equivalent to an infinite approval.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, amount);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20}.
     *
     * NOTE: Does not update the allowance if the current allowance
     * is the maximum `uint256`.
     *
     * Requirements:
     *
     * - `from` and `to` cannot be the zero address.
     * - `from` must have a balance of at least `amount`.
     * - the caller must have allowance for ``from``'s tokens of at least
     * `amount`.
     */
    function transferFrom(address from, address to, uint256 amount) public virtual override returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, allowance(owner, spender) + addedValue);
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        address owner = _msgSender();
        uint256 currentAllowance = allowance(owner, spender);
        require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
        unchecked {
            _approve(owner, spender, currentAllowance - subtractedValue);
        }

        return true;
    }

    /**
     * @dev Moves `amount` of tokens from `from` to `to`.
     *
     * This internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `from` must have a balance of at least `amount`.
     */
    function _transfer(address from, address to, uint256 amount) internal virtual {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(from, to, amount);

        uint256 fromBalance = _balances[from];
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
        unchecked {
            _balances[from] = fromBalance - amount;
            // Overflow not possible: the sum of all balances is capped by totalSupply, and the sum is preserved by
            // decrementing then incrementing.
            _balances[to] += amount;
        }

        emit Transfer(from, to, amount);

        _afterTokenTransfer(from, to, amount);
    }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     */
    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply += amount;
        unchecked {
            // Overflow not possible: balance + amount is at most totalSupply + amount, which is checked above.
            _balances[account] += amount;
        }
        emit Transfer(address(0), account, amount);

        _afterTokenTransfer(address(0), account, amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
        unchecked {
            _balances[account] = accountBalance - amount;
            // Overflow not possible: amount <= accountBalance <= totalSupply.
            _totalSupply -= amount;
        }

        emit Transfer(account, address(0), amount);

        _afterTokenTransfer(account, address(0), amount);
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner` s tokens.
     *
     * This internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(address owner, address spender, uint256 amount) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    /**
     * @dev Updates `owner` s allowance for `spender` based on spent `amount`.
     *
     * Does not update the allowance amount in case of infinite allowance.
     * Revert if not enough allowance is available.
     *
     * Might emit an {Approval} event.
     */
    function _spendAllowance(address owner, address spender, uint256 amount) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= amount, "ERC20: insufficient allowance");
            unchecked {
                _approve(owner, spender, currentAllowance - amount);
            }
        }
    }

    /**
     * @dev Hook that is called before any transfer of tokens. This includes
     * minting and burning.
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * will be transferred to `to`.
     * - when `from` is zero, `amount` tokens will be minted for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens will be burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual {}

    /**
     * @dev Hook that is called after any transfer of tokens. This includes
     * minting and burning.
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * has been transferred to `to`.
     * - when `from` is zero, `amount` tokens have been minted for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens have been burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _afterTokenTransfer(address from, address to, uint256 amount) internal virtual {}
}

// File: @openzeppelin/contracts/security/ReentrancyGuard.sol


// OpenZeppelin Contracts (last updated v4.9.0) (security/ReentrancyGuard.sol)

pragma solidity ^0.8.0;

/**
 * @dev Contract module that helps prevent reentrant calls to a function.
 *
 * Inheriting from `ReentrancyGuard` will make the {nonReentrant} modifier
 * available, which can be applied to functions to make sure there are no nested
 * (reentrant) calls to them.
 *
 * Note that because there is a single `nonReentrant` guard, functions marked as
 * `nonReentrant` may not call one another. This can be worked around by making
 * those functions `private`, and then adding `external` `nonReentrant` entry
 * points to them.
 *
 * TIP: If you would like to learn more about reentrancy and alternative ways
 * to protect against it, check out our blog post
 * https://blog.openzeppelin.com/reentrancy-after-istanbul/[Reentrancy After Istanbul].
 */
abstract contract ReentrancyGuard {
    // Booleans are more expensive than uint256 or any type that takes up a full
    // word because each write operation emits an extra SLOAD to first read the
    // slot's contents, replace the bits taken up by the boolean, and then write
    // back. This is the compiler's defense against contract upgrades and
    // pointer aliasing, and it cannot be disabled.

    // The values being non-zero value makes deployment a bit more expensive,
    // but in exchange the refund on every call to nonReentrant will be lower in
    // amount. Since refunds are capped to a percentage of the total
    // transaction's gas, it is best to keep them low in cases like this one, to
    // increase the likelihood of the full refund coming into effect.
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;

    uint256 private _status;

    constructor() {
        _status = _NOT_ENTERED;
    }

    /**
     * @dev Prevents a contract from calling itself, directly or indirectly.
     * Calling a `nonReentrant` function from another `nonReentrant`
     * function is not supported. It is possible to prevent this from happening
     * by making the `nonReentrant` function external, and making it call a
     * `private` function that does the actual work.
     */
    modifier nonReentrant() {
        _nonReentrantBefore();
        _;
        _nonReentrantAfter();
    }

    function _nonReentrantBefore() private {
        // On the first call to nonReentrant, _status will be _NOT_ENTERED
        require(_status != _ENTERED, "ReentrancyGuard: reentrant call");

        // Any calls to nonReentrant after this point will fail
        _status = _ENTERED;
    }

    function _nonReentrantAfter() private {
        // By storing the original value once again, a refund is triggered (see
        // https://eips.ethereum.org/EIPS/eip-2200)
        _status = _NOT_ENTERED;
    }

    /**
     * @dev Returns true if the reentrancy guard is currently set to "entered", which indicates there is a
     * `nonReentrant` function in the call stack.
     */
    function _reentrancyGuardEntered() internal view returns (bool) {
        return _status == _ENTERED;
    }
}

// File: contracts/roy.sol


pragma solidity ^0.8.24;



contract numericalVault1 is ReentrancyGuard{

    ERC20 usdcAddress = ERC20(0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913);
    uint256 decimals = 6;

    address public owner;
    address public adminWallet;

    uint256 public totalDeposited = 0;
    uint256 public totalPending = 0;

    uint256 public lastEpochTime;
    uint256 public currentEpoch = 0;

    struct rewardHistory {
        uint256 totalDeposit;
        uint256 reward;
        uint256 epochTime;
        uint256 adminBalance;
    }
    rewardHistory[] history;

    address[] sucessfullyDeposited;
    address[] awaitingApproval;
    address[] withdrawRequests;

    struct depositor {
        uint256 amount;
        uint256 pendingAmount;

        uint256 initialDepositTime;
        uint256 reDepositTime;

        bool withdrawApproved;
        uint256 withdrawableAmount;
        uint256 withrawalRequestAmount;
        
        uint256 claimableRewards;
        uint256 claimedRewards;
    }
    mapping (address => depositor) userDepositInfo;

    constructor(address _owner, address _adminWallet) {
        require(_owner != address(0), "Owner address cannot be zero");
        require(_adminWallet != address(0), "Admin wallet cannot be zero");

        lastEpochTime = block.timestamp;
        owner = _owner;
        adminWallet = _adminWallet;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function getAwaitingApproval() external view returns (address[] memory){
        return awaitingApproval;
    }

    function getWithdrawRequests() external view returns (address[] memory){
        return withdrawRequests;
    }

    function getSuccessfullyDeposited() external view returns (address[] memory){
        return sucessfullyDeposited;
    }

    function getHistory() external view returns (rewardHistory[] memory){
        return history;
    }

    function getWithdrawRequestsAmount() external view returns(uint256) {
        uint256 withdrawAmount;
        for (uint i = 0; i < withdrawRequests.length; i++) 
        {
            depositor memory user = userDepositInfo[withdrawRequests[i]];
            withdrawAmount += user.withrawalRequestAmount;
        }

        return withdrawAmount;
    }

    function getUserDeposit(address addr) external view returns (depositor memory) {
        return userDepositInfo[addr];
    }

    function changeAdminWallet(address newWallet) external onlyOwner {
        adminWallet = newWallet;
    }

    function removeTokens() external onlyOwner {
        require(usdcAddress.transfer(adminWallet, usdcAddress.balanceOf(address(this))));
    }

    function deposit(uint256 amount) external nonReentrant{
        depositor storage userInfo = userDepositInfo[msg.sender];

        bool hasUserAlreadyDeposited = userInfo.initialDepositTime > 0;

        if(!hasUserAlreadyDeposited){
            userInfo.initialDepositTime = block.timestamp;
        }else{
            userInfo.reDepositTime = block.timestamp;
        }

        userInfo.pendingAmount += amount;
        totalPending += amount;

        // if user has no pending request, create one
        if(findAddressIndex(awaitingApproval, msg.sender) > awaitingApproval.length){
            awaitingApproval.push(msg.sender);
        }

        require(usdcAddress.balanceOf(msg.sender) >= amount);
        require(usdcAddress.transferFrom(msg.sender, adminWallet, amount));
    }

    function startNewCycle() external onlyOwner {
        for (uint i = 0; i < awaitingApproval.length; i++) 
        {
            depositor storage user = userDepositInfo[awaitingApproval[i]];
            if(findAddressIndex(sucessfullyDeposited, awaitingApproval[i]) > sucessfullyDeposited.length){
                sucessfullyDeposited.push(awaitingApproval[i]);
            }

            uint256 pendingAmount = user.pendingAmount;

            user.amount += pendingAmount;
            user.pendingAmount = 0;

            totalDeposited += pendingAmount;

        }

        // clear total pending amount
        totalPending = 0;
        lastEpochTime = block.timestamp;
        currentEpoch += 1;

        delete awaitingApproval;
    }

    function approveWithdrawRequests() external onlyOwner {
        // total to be taken from admin wallet
        uint256 totalWithdrawAmount;

        for (uint i = 0; i < withdrawRequests.length; i++) 
        {
            depositor storage user = userDepositInfo[withdrawRequests[i]];
            uint256 withdrawAmount = user.withrawalRequestAmount;

            // take the amount from the pending first
            if(user.pendingAmount > 0){
                if(withdrawAmount > user.pendingAmount){
                    withdrawAmount -= user.pendingAmount;
                    totalPending -= user.pendingAmount;
                    user.pendingAmount = 0;

                    // user has no more pending amount, delete address from awaitingApproval array
                    awaitingApproval = deleteAddressFromArray(awaitingApproval, withdrawRequests[i]);
                }else{
                    user.pendingAmount -= withdrawAmount;
                    totalPending -= withdrawAmount;
                    withdrawAmount = 0;
                }
            }

            // take the rest from the deposited amount
            if(withdrawAmount > 0){
                user.amount -= withdrawAmount;

                // total deposit decreases by the amount removed from amount, not from pending amount
                totalDeposited -= withdrawAmount;
            }

            totalWithdrawAmount += user.withrawalRequestAmount;

            user.withdrawApproved = true;
            user.withdrawableAmount = user.withrawalRequestAmount;
            user.withrawalRequestAmount = 0;

            // user has no more deposit left, remove from sucessfullyDeposited array
            if(user.amount == 0){
                sucessfullyDeposited = deleteAddressFromArray(sucessfullyDeposited, withdrawRequests[i]);
            }
        }

        delete withdrawRequests;

        bool sent = usdcAddress.transferFrom(adminWallet, address(this), totalWithdrawAmount);
        require(sent, "Failed to transfer withdraw amount");
    }

    function requestWithdraw(uint256 amount) external nonReentrant{
        depositor storage userInfo = userDepositInfo[msg.sender];

        // check if user is elligible
        require(userInfo.amount > 0 || userInfo.pendingAmount > 0);

        // check if user has enough amount to request withdraw
        require(userInfo.amount + userInfo.pendingAmount >= userInfo.withrawalRequestAmount + amount);

        userInfo.withrawalRequestAmount += amount;

        // if user does not have an ongoing request, create one
        if(findAddressIndex(withdrawRequests, msg.sender) > withdrawRequests.length){
            withdrawRequests.push(msg.sender);
        }
    }

    function cancelRequestWithdraw() external nonReentrant{
        depositor storage userInfo = userDepositInfo[msg.sender];
        // check if request is present
        require(findAddressIndex(withdrawRequests, msg.sender) <= withdrawRequests.length);

        // clear withdraw request
        userInfo.withrawalRequestAmount = 0;

        // delete address from requests array
        withdrawRequests = deleteAddressFromArray(withdrawRequests, msg.sender);
    }

    function withdraw() external nonReentrant{
        depositor storage userInfo = userDepositInfo[msg.sender];

        require(userInfo.withdrawApproved);

        userInfo.withdrawApproved = false;

        uint256 amountToSend = userInfo.withdrawableAmount;
        userInfo.withdrawableAmount = 0;

        require(usdcAddress.balanceOf(address(this)) >= amountToSend);
        require(usdcAddress.transfer(msg.sender, amountToSend));
    }
    
    function distributeRewards(uint256 amount, uint256 adminBalance) external onlyOwner {

        for (uint i = 0; i < sucessfullyDeposited.length; i++) 
        {
            depositor storage userInfo = userDepositInfo[sucessfullyDeposited[i]];
            uint256 userReward = userInfo.amount * amount / totalDeposited;

            userInfo.claimableRewards += userReward;
        }

        history.push(rewardHistory(totalDeposited, amount, block.timestamp - lastEpochTime, adminBalance));
        bool sent = usdcAddress.transferFrom(adminWallet, address(this), amount);
        require(sent, "Failed to transfer funds from admin wallet");
    }

    function claimRewards() external nonReentrant{
        depositor storage userInfo = userDepositInfo[msg.sender];

        require(userInfo.claimableRewards > 0);
        uint256 userReward = userInfo.claimableRewards;
        userInfo.claimableRewards = 0;
        userInfo.claimedRewards += userReward;

        require(usdcAddress.balanceOf(address(this)) >= userReward);
        require(usdcAddress.transfer(msg.sender, userReward));
    }

    function reDeposit() external nonReentrant{ //
        depositor storage userInfo = userDepositInfo[msg.sender];
        require(userInfo.claimableRewards > 0);

        uint256 userReward = userInfo.claimableRewards;
        userInfo.claimableRewards = 0;
        userInfo.pendingAmount += userReward;
        userInfo.reDepositTime = block.timestamp;

        totalPending += userReward;

        // if user has no pending request, create one
        if(findAddressIndex(awaitingApproval, msg.sender) > awaitingApproval.length){
            awaitingApproval.push(msg.sender);
        }

        require(usdcAddress.balanceOf(address(this)) >= userReward);
        require(usdcAddress.transfer(adminWallet, userReward));
    }

    function findAddressIndex(address[] memory addressArray, address addressToFind) internal pure returns (uint) {
        for (uint i = 0; i < addressArray.length; i++) {
            if (addressArray[i] == addressToFind) {
                return i;
            }
        }
        return type(uint).max; // Number not found, return a value outside the array bounds
    }

    function deleteAddressFromArray(address[] memory addressArray, address addressToDelete) internal pure returns (address[] memory) {
        address[] memory newArray = new address[](addressArray.length - 1);

        uint indexToDelete = findAddressIndex(addressArray, addressToDelete);
        require(indexToDelete < addressArray.length, "Number not found in the array");

        for (uint i = 0; i < indexToDelete; i++) {
            newArray[i] = addressArray[i];
        }
        for (uint i = indexToDelete; i < newArray.length; i++) {
            newArray[i] = addressArray[i + 1];
        }

        return newArray;
    }

}