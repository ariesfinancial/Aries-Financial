/**
 *Submitted for verification at Etherscan.io on 2021-01-21
*/

// SPDX-License-Identifier: MIT
// AND GPL-3.0-or-later
pragma solidity 0.7.5;
// includes Openzeppelin 3.3.0 contracts:
// ... Context -> Ownable
// ... SafeMath, Address, SafeERC20
// ... IERC20, ERC20(aka ERC20Detailed),

// File: @openzeppelin/contracts/GSN/Context.sol
abstract contract Context {
    function _msgSender() internal view virtual returns (address payable) {
        return msg.sender;
    }

    // function _msgData() internal view virtual returns (bytes memory) {
    //     this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
    //     return msg.data;
    // }
}

// File: @openzeppelin/contracts/access/Ownable.sol
//import "../GSN/Context.sol";
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(_owner == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

// File: @openzeppelin/contracts/token/ERC20/IERC20.sol
interface IERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

// File: @openzeppelin/contracts/math/SafeMath.sol
library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    // function mod(uint256 a, uint256 b) internal pure returns (uint256) {
    //     return mod(a, b, "SafeMath: modulo by zero");
    // }

    // function mod(
    //     uint256 a,
    //     uint256 b,
    //     string memory errorMessage
    // ) internal pure returns (uint256) {
    //     require(b != 0, errorMessage);
    //     return a % b;
    // }
}

// File: @openzeppelin/contracts/utils/Address.sol
//pragma solidity >=0.6.2 <0.8.0;

library Address {
    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        uint256 size;
        // solhint-disable-next-line no-inline-assembly
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */

    // function sendValue(address payable recipient, uint256 amount) internal {
    //     require(
    //         address(this).balance >= amount,
    //         "Address: insufficient balance"
    //     );

    //     // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
    //     (bool success, ) = recipient.call{value: amount}("");
    //     require(
    //         success,
    //         "Address: unable to send value, recipient may have reverted"
    //     );
    // }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain`call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    // function functionCall(address target, bytes memory data)
    //     internal
    //     returns (bytes memory)
    // {
    //     return functionCall(target, data, "Address: low-level call failed");
    // }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return
            functionCallWithValue(
                target,
                data,
                value,
                "Address: low-level call with value failed"
            );
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(
            address(this).balance >= value,
            "Address: insufficient balance for call"
        );
        require(isContract(target), "Address: call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) =
            target.call{value: value}(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    // functionStaticCall x2

    function _verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) private pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

// File: @openzeppelin/contracts/token/ERC20/SafeERC20.sol
// pragma solidity >=0.6.0 <0.8.0;
// import "./IERC20.sol";
// import "../../math/SafeMath.sol";
// import "../../utils/Address.sol";

library SafeERC20 {
    using SafeMath for uint256;
    using Address for address;

    function safeTransfer(
        IERC20 token,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(
            token,
            abi.encodeWithSelector(token.transfer.selector, to, value)
        );
    }

    function safeTransferFrom(
        IERC20 token,
        address from,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(
            token,
            abi.encodeWithSelector(token.transferFrom.selector, from, to, value)
        );
    }

    /**
     * @dev Deprecated. This function has issues similar to the ones found in
     * {IERC20-approve}, and its usage is discouraged.
     *
     * Whenever possible, use {safeIncreaseAllowance} and
     * {safeDecreaseAllowance} instead.
     */
    function safeApprove(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        // safeApprove should only be called when setting an initial allowance,
        // or when resetting it to zero. To increase and decrease it, use
        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
        // solhint-disable-next-line max-line-length
        require(
            (value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        _callOptionalReturn(
            token,
            abi.encodeWithSelector(token.approve.selector, spender, value)
        );
    }

    function safeIncreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        uint256 newAllowance =
            token.allowance(address(this), spender).add(value);
        _callOptionalReturn(
            token,
            abi.encodeWithSelector(
                token.approve.selector,
                spender,
                newAllowance
            )
        );
    }

    function safeDecreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        uint256 newAllowance =
            token.allowance(address(this), spender).sub(
                value,
                "SafeERC20: decreased allowance below zero"
            );
        _callOptionalReturn(
            token,
            abi.encodeWithSelector(
                token.approve.selector,
                spender,
                newAllowance
            )
        );
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We use {Address.functionCall} to perform this call, which verifies that
        // the target address contains contract code and also asserts for success in the low-level call.

        bytes memory returndata =
            address(token).functionCall(
                data,
                "SafeERC20: low-level call failed"
            );
        if (returndata.length > 0) {
            // Return data is optional
            // solhint-disable-next-line max-line-length
            require(
                abi.decode(returndata, (bool)),
                "SafeERC20: ERC20 operation did not succeed"
            );
        }
    }
}


pragma abicoder v2;
//import "./openzeppelinERC20ITF.sol";
//import "./signedSafeMath.sol";

interface IABDKMathQuadFunc {
  function mulMul(uint256 x, uint256 y, uint256 z) external pure returns (uint256);
  function mulDiv(uint256 x, uint256 y, uint256 z) external pure returns (uint256);
}

abstract contract Administration is Ownable {
    address private admin;
    address private governance;
    event AccountTransferred(
        address indexed previousAccount,
        address indexed newAccount
    );
    constructor () {
        admin = _msgSender();
        governance = _msgSender();
    }
    modifier onlyAdmin() {
        require(_msgSender() == admin, "Caller is not admin");
        _;
    }
    function isOnlyAdmin() public view returns (bool) {
        return _msgSender() == admin;
    }
    function transferAdmin(address newAdmin) public onlyOwner {
        require(newAdmin != address(0), "cannot be zero address");
        emit AccountTransferred(admin, newAdmin);
        admin = newAdmin;
    }
    //-------------------==
    function isOnlyGov() public view returns (bool) {
        return _msgSender() == governance;
    }
    function transferGov(address newGov) public onlyOwner {
        require(newGov != address(0), "cannot be zero address");
        emit AccountTransferred(governance, newGov);
        governance = newGov;
    }
}


contract PriceBettingT1S is Administration {
    using SafeMath for uint256;
    //using SignedSafeMath for int256;
    using SafeERC20 for IERC20;
    using Address for address;

    event SetVault(address indexed user, address indexed newAddr);

    event Win(
        address indexed user,
        uint256 indexed timestamp,
        uint256 payout,
        uint256 betIdx,
        uint256 indexed period
    );
    event Lose(
        address indexed user,
        uint256 indexed timestamp,
        uint256 payout,
        uint256 betIdx,
        uint256 indexed period
    );
    event Tie(
        address indexed user,
        uint256 indexed timestamp,
        uint256 payout,
        uint256 betIdx,
        uint256 indexed period
    );
    // uint256 public constant MIN1 = 1 minutes; //60
    // uint256 public constant MIN5 = 5 minutes; //300

    AggregatorEthereumV3 internal BTCUSDpriceFeedEtheremV3;
    AggregatorEthereumV3 internal ETHUSDpriceFeedEtheremV3;
    AggregatorXDAI internal BTCUSDpriceFeedXDAI;
    AggregatorXDAI internal ETHUSDpriceFeedXDAI;
    uint256 public EVMChainID = 100;

    uint256 public idxStart60 = 0;
    uint256 public idxStart300 = 0;
    uint256 public idxEnd60 = 0;
    uint256 public idxEnd300 = 0;
    uint256 public maxBetPoolRatio = 5;
    uint256 public maxOldBetsAmountToClear = 3;
    address private vault;
    uint256 public fakePriceBTC = 3681613790994;
    uint256 public fakePriceETH =  142913790994;
    bool public isLivePrice;

    mapping(uint256 => Bet) public bets60;
    mapping(uint256 => Bet) public bets300;

    IERC20 public token;
    IABDKMathQuadFunc public ABDKMathQuadFunc;
    //IStakingPool public stakingPool;

    constructor() {
        token = IERC20(0x61ad86291Cf96A43265c0c73B219Ae5Fd7ca368b);
        isLivePrice = true;
        ABDKMathQuadFunc = IABDKMathQuadFunc(0x9b3847a3715C489c819fE98dAEcc48af60006ed7);
        //stakingPool = IStakingPool(_stakingPool);
    }//, address _stakingPool

    //--------------------== onlyAdmin settings
    function setFakePriceBTC(uint256 _fakePriceBTC) external onlyAdmin {
        fakePriceBTC = _fakePriceBTC;
    }

    function setFakePriceETH(uint256 _fakePriceETH) external onlyAdmin {
        fakePriceETH = _fakePriceETH;
    }

    function setVault(address _vault) external onlyAdmin {
        //require(address(token).isContract(), "call to non-contract");
        require(_vault != address(0), "vault cannot be zero address");
        vault = _vault;
        emit SetVault(msg.sender, _vault);
    }

    function setMaxBetPoolRatio(uint256 _maxBetPoolRatio) external onlyAdmin {
        require(_maxBetPoolRatio > 0 && _maxBetPoolRatio <= 10, "amount invalid");
        maxBetPoolRatio = _maxBetPoolRatio;
    }

    function setMaxOldBetsAmountToClear(uint256 _maxOldBetsAmountToClear)
        external
        onlyAdmin
    {
        require(_maxOldBetsAmountToClear > 0, "amount cannot be 0");
        maxOldBetsAmountToClear = _maxOldBetsAmountToClear;
    }

    function setProfitRatio(uint256 profitRatio1) external onlyAdmin {
        require(profitRatio1 > 0 && profitRatio1 <= 100, "ratio invalid");
        profitRatio = profitRatio1;
    }
    function setEVMChainID(uint256 _EVMChainID) external onlyAdmin {
        EVMChainID = _EVMChainID;
    }

    function setBTCUSDpriceFeed(address addr) external onlyAdmin {
        require(address(addr).isContract(), "address is non-contract");
        if (EVMChainID == 100) {
            BTCUSDpriceFeedXDAI = AggregatorXDAI(addr);
        } else if (EVMChainID == 1) {
            BTCUSDpriceFeedEtheremV3 = AggregatorEthereumV3(addr);
        } else if (EVMChainID == 4) {
            BTCUSDpriceFeedEtheremV3 = AggregatorEthereumV3(addr);
        } else if (EVMChainID == 42) {
            BTCUSDpriceFeedEtheremV3 = AggregatorEthereumV3(addr);
        }
    }

    function setETHUSDpriceFeed(address addr) external onlyAdmin {
        require(address(addr).isContract(), "address is non-contract");
        if (EVMChainID == 100) {
            ETHUSDpriceFeedXDAI = AggregatorXDAI(addr);
        } else if (EVMChainID == 1) {
            ETHUSDpriceFeedEtheremV3 = AggregatorEthereumV3(addr);
        } else if (EVMChainID == 4) {
            ETHUSDpriceFeedEtheremV3 = AggregatorEthereumV3(addr);
        } else if (EVMChainID == 42) {
            ETHUSDpriceFeedEtheremV3 = AggregatorEthereumV3(addr);
        }
    }

    //--------------------== Public functions
    function getDataBetIndexes() public view returns (
            uint256, uint256, uint256, uint256, uint256,
            uint256, uint256, uint256){
        //uints = new uint256[](9);
        return (block.timestamp, idxStart60, idxEnd60,
            idxStart300, idxEnd300, maxOldBetsAmountToClear, profitRatio,
            maxBetPoolRatio);
    }

    function clearBetsExternal(uint256 period) public onlyAdmin {
        require(period == 60 || period == 300, "invalid period");
        (uint256 priceBTC, uint256 priceETH) = getLatestPrices();
        clearBets(block.timestamp, priceBTC, priceETH, period);
    }
    // function calcMaxBet() public view returns (uint256) {
    //       return ABDKMathQuadFunc.mulDiv(poolBalance, maxBetPoolRatio, 100);//poolBalance.mul(maxBetPoolRatio).div(100);
    // }
    function enterBetCheck(
        uint256 amount,
        uint256 period,
        uint256 bettingOutcome,
        uint256 tokenPair,
        uint256 fundingSource
    ) public view returns(
      bool[] memory bools, uint[] memory uints, bool boolOut) {
        bools = new bool[](8);
        uints = new uint256[](4);
        uint256 maxBet = ABDKMathQuadFunc.mulDiv(poolBalance, maxBetPoolRatio, 100);//calcMaxBet();
        bools[0] = amount > 0 && amount <= maxBet;
        bools[1] = period == 60 || period == 300;
        bools[2] = bettingOutcome < 2;
        bools[3] = tokenPair < 2;// BTCUSD: 0, ETHUSD: 1
        bools[4] = fundingSource < 2;// balance: 0, deposit: 1
        uint256 maxTotalUnclaimedOut = maxTotalUnclaimed();
        bools[5] = totalUnclaimed <= maxTotalUnclaimedOut;
        uint256 tokenBalanceAtFundingSrc;

        if(fundingSource == 0) {
            tokenBalanceAtFundingSrc = betters[msg.sender].deposit;
            bools[7] = totalUnclaimed >= amount && betters[msg.sender].unclaimed >= amount;

        } else {
            tokenBalanceAtFundingSrc = token.balanceOf(msg.sender);
            bools[7] = true;
        }
        bools[6] = tokenBalanceAtFundingSrc >= amount;
        boolOut = bools[0] && bools[1] && bools[2] && bools[3] && bools[4] && bools[5] && bools[6] && bools[7];
        //boolOut = true;
        // for(uint i = 0; i < bools.length; i++) {
        //     boolOut = boolOut && bools[i];
        // }

        uints[0] = maxBet;
        uints[1] = tokenBalanceAtFundingSrc;
        uints[2] = totalUnclaimed;
        uints[3] = maxTotalUnclaimedOut;
    }

    function enterBet(
        uint256 amount,
        uint256 period,
        uint256 bettingOutcome,
        uint256 tokenPair,
        uint256 fundingSource
    ) external {
        ( , , bool boolOut) = enterBetCheck(amount, period, bettingOutcome, tokenPair, fundingSource);
        require(boolOut, "invalid input detected");

        uint256 price;
        (uint256 priceBTC, uint256 priceETH) = getLatestPrices();
        if (tokenPair == 0) {
            price = priceBTC;
        } else if (tokenPair == 1) {
            price = priceETH;
        }
        clearBets(block.timestamp, priceBTC, priceETH, period);

        if(fundingSource == 0){
            //console.log("[sc] ----== transfer better's deposits");
            updateBetterDeposit(false, amount, msg.sender);
        } else {
            //console.log("[sc] ----== transfer bet tokens");
            token.safeTransferFrom(msg.sender, address(this), amount);
        }

        Bet memory bet;
        bet.addr = msg.sender;
        bet.betAt = block.timestamp;
        bet.amount = amount;
        bet.period = period;
        bet.priceAtBet = price;
        bet.bettingOutcome = bettingOutcome;
        bet.tokenPair = tokenPair;
        bet.fundingSource = fundingSource;
        bet.result = -1;

        totalBetAmount = totalBetAmount.add(amount);
        //console.log("[sc] bet:", bet);

        if (period == 60) {
            idxEnd60 = idxEnd60.add(1);
            bets60[idxEnd60] = bet;
            if (idxEnd60 == 1) {
                idxStart60 = 1;
            }
        } else if (period == 300) {
            idxEnd300 = idxEnd300.add(1);
            bets300[idxEnd300] = bet;
            if (idxEnd300 == 1) {
                idxStart300 = 1;
            }
        }
    }

    //enum FundingSource{deposit, balance}
    struct Bet {
        address addr;
        uint256 betAt; //time this bet was recorded
        uint256 amount; //amount of betting
        uint256 period; //in seconds
        uint256 priceAtBet;
        uint256 bettingOutcome; //0 down, 1 up, 2 same, 3 uknown
        uint256 tokenPair; //0 BTC, 1 ETH
        uint256 fundingSource;//0 balance, 1 deposit
        int256  result;//amount*1.88 as total winning amount, and 0 for losing the bet amount, amount*1 as tie returned to the better
        //uint256 paidAt; //time this bet was paid
    }

    function getBet(uint256 period, uint256 betIdx) public view returns (Bet memory bet) {
        if (period == 60) bet = bets60[betIdx];
        if (period == 300) bet = bets300[betIdx];
    }
    function setBetResult(uint256 period, uint256 betIdx, uint256 result) private {
        if (period == 60) {
          bets60[betIdx].result = int256(result);
        } else if (period == 300) {
          bets300[betIdx].result = int256(result);
        }
    }

    function clearBets(
        uint256 blockTime,
        uint256 priceBTC,
        uint256 priceETH,
        uint256 period
    ) private {
        //loop to clear max 4 old bets
        //console.log("[sc] clearBets()");
        uint256 idxStart;
        uint256 idxEnd;
        if (period == 60) {
            idxStart = idxStart60;
            idxEnd = idxEnd60;
        } else if (period == 300) {
            idxStart = idxStart300;
            idxEnd = idxEnd300;
        }
        if (idxStart > 0 && idxEnd >= idxStart) {
            //console.log("[sc] betIdx start & end good");
            for (
                uint256 betIdx = idxStart;
                betIdx < idxStart.add(maxOldBetsAmountToClear);
                betIdx++
            ) {
                //console.log("[sc] ----------== loop");
                //console.log("[sc] betIdx: %s, period: %s", betIdx, period);
                Bet memory bet = getBet(period, betIdx);

                //console.log("bet:: betAt: %s, blockTime: %s",  bet.betAt, blockTime);
                if (bet.betAt == 0) {
                    //console.log("[sc] ----== all bets have been settled");
                    break;
                }
                if (blockTime < bet.betAt.add(period)) {
                    //console.log("[sc] ----== bets are waiting");
                    break;
                }
                if (bet.tokenPair == 0) {//BTC
                    settle(period, betIdx, priceBTC); 
                } else {//ETH
                    settle(period, betIdx, priceETH); 
                }
                if (period == 60) {
                    idxStart60 = idxStart60.add(1);
                }
                if (period == 300) {
                    idxStart300 = idxStart300.add(1);
                }
            }
        }
    }

    // function calcAmounts(uint256 amount) public view returns (uint256 gain, uint256 gainAndPrincipal, uint256 govGain) {
    //     gain = ABDKMathQuadFunc.mulDiv(amount, profitRatio, 100);//0.88
    //     gainAndPrincipal = amount.add(gain);//1.88
    //     govGain = amount.sub(gain);//0.12
    // }
    function settle(
        uint256 period,
        uint256 betIdx,
        uint256 price
    ) private {
        Bet memory bet = getBet(period, betIdx);
        //console.log("[sc] settle(): betIdx: %s, priceNow: %s", betIdx, price);
        //console.log("[sc] priceAtBet: %s, bettingOutcome: %s",bet.priceAtBet, bet.bettingOutcome);

        //(uint256 gain, uint256 gainAndPrincipal, uint256 govGain) = calcAmounts(bet.amount);
        uint256 gain = ABDKMathQuadFunc.mulDiv(bet.amount, profitRatio, 100);//0.88
        uint256 gainAndPrincipal = bet.amount.add(gain);//1.88
        uint256 govGain = bet.amount.sub(gain);//0.12

        //console.log("bet.amount", bet.amount, gain, gainAndPrincipal);

        totalBetAmount = totalBetAmount.sub(bet.amount);

        if (price < bet.priceAtBet) {
            govBalance = govBalance.add(govGain);
            if (bet.bettingOutcome == 0) {
                //console.log("[sc] ----== Win1: price down");
                handleWinning(period, betIdx, gain, gainAndPrincipal);
            } else {
                //console.log("[sc] ----== Lose1: price down");
                handleLosing(period, betIdx, gain);
            }
        } else if (price > bet.priceAtBet) {
            govBalance = govBalance.add(govGain);
            if (bet.bettingOutcome == 1) {
                //console.log("[sc] ----== Win2: price up");
                handleWinning(period, betIdx, gain, gainAndPrincipal);
            } else {
                //console.log("[sc] ----== Lose2: price up");
                handleLosing(period, betIdx, gain);
            }
        } else {
            //console.log("[sc] ----== Same price");
            handleTie(period, betIdx);
        }
    }



    //--------------------== 
    uint256 public profitRatio = 88;//lesser than 100
    uint256 public maxUnclaimedPoolRatio= 50;//<100

    function maxTotalUnclaimed() public view returns (uint256) {
        return ABDKMathQuadFunc.mulDiv(poolBalance, maxUnclaimedPoolRatio,100);
    }
    // function isOverBetting() public view returns (bool) {
    //     return totalUnclaimed > maxTotalUnclaimed();
    // }

/*struct Bet {
        address addr;
        uint256 betAt; //time this bet was recorded
        uint256 amount; //amount of betting
        uint256 period; //in seconds
        uint256 priceAtBet;
        uint256 bettingOutcome; //0 down, 1 up, 2 same, 3 uknown
        uint256 tokenPair; //0 BTC, 1 ETH
        uint256 result;//amount*1.88 as total winning amount, and 0 for losing the bet amount, amount*1 as tie returned to the better
        uint256 fundingSource;
    }*/
    function handleWinning(uint256 period, uint256 betIdx, uint256 gain, uint256 gainAndPrincipal) internal {
        //console.log("[sc] ----== handleWinning");
        //console.log("[sc] handleWinning",gain, gainAndPrincipal);
        Bet memory bet = getBet(period, betIdx);
        poolBalance = poolBalance.sub(bet.amount);
        // Pool loses 1, the governance gets 0.12

        uint256 amt;//add to totalUnclaimed and unclaimed 
        if(bet.fundingSource == 0){//balance: 0.88
            amt = gain;
        } else {//deposit: 1.88
            amt = gainAndPrincipal;
        //token.safeTransfer(bet.addr, gainAndPrincipal);
//amount*1.88 as total winning amount, and 0 for losing the bet amount, amount*1 as tie returned to the better
        }
        //console.log("[sc] amt:", amt);
        totalUnclaimed = totalUnclaimed.add(amt);
        updateBetterUnclaimed(true, amt, bet.addr);
        setBetResult(period, betIdx, gainAndPrincipal);
        Win(bet.addr, block.timestamp, amt, betIdx, bet.period);
    }

    function handleLosing(uint256 period, uint256 betIdx, uint256 gain) internal {
        //console.log("[sc] ----== handleLosing");
        Bet memory bet = getBet(period, betIdx);
        poolBalance = poolBalance.add(gain);
        // Pool gets 0.88, the governance gets 0.12

        if(bet.fundingSource == 0){//use user's balance: totalUnclaimed and unclaimed substract 1
            totalUnclaimed=totalUnclaimed.sub(bet.amount);
            updateBetterUnclaimed(false, bet.amount, bet.addr);
        }//else for deposit: he loses 1[no change]
        setBetResult(period, betIdx, 0);
        Lose(bet.addr, block.timestamp, bet.amount, betIdx, bet.period);
    }

    function handleTie(uint256 period, uint256 betIdx) internal {
        //console.log("[sc] ----== handleTie");
        Bet memory bet = getBet(period, betIdx);
        //Pool gets nothing, the governance gets 0.
        if(bet.fundingSource == 0){
            //use user's balance: he gets refund 1, 
        } else {//deposit: he gets refund 1
            //token.safeTransfer(bet.addr, bet.amount);
        }
        totalDeposits = totalDeposits.add(bet.amount);
        updateBetterDeposit(true, bet.amount, bet.addr);
        setBetResult(period, betIdx, bet.amount);
        Tie(bet.addr, block.timestamp, bet.amount, betIdx, bet.period);
    }

    //-----------------== Pool
    uint256 public sharePriceUnit = 1000;//1*(10**9);
    uint256 public totalShares;
    uint256 public poolBalance;
    mapping(address => Pooler) public poolers;
    struct Pooler {
        uint256 shares;
        uint256 staking;//in token unit
    }

    function getDataStaking() external view returns (uint256, uint256, uint256, Pooler memory, uint256, int256){
        uint256 sharePrice;
        uint256 effTokenBalance;// poolerBalance
        if(totalShares == 0) {
          sharePrice = 1 * sharePriceUnit;
          effTokenBalance = poolers[msg.sender].shares;
        } else {
          sharePrice = ABDKMathQuadFunc.mulDiv(poolBalance, sharePriceUnit, totalShares);
          effTokenBalance = ABDKMathQuadFunc.mulDiv(poolBalance, poolers[msg.sender].shares, totalShares);
        }
        //int256 winloseBalance = effTokenBalance - poolers[msg.sender].staking;
      return (poolBalance, totalShares, sharePrice, poolers[msg.sender], effTokenBalance, int256(effTokenBalance) - int256(poolers[msg.sender].staking));   
    }
    // function effTokenBalances() external view returns (uint256 effTokenBalance, uint256 winloseBalance) {
    //     effTokenBalance = ABDKMathQuadFunc.mulDiv(poolBalance, poolers[msg.sender].shares, totalShares);
    //     winloseBalance = effTokenBalance - poolers[msg.sender].staking;
    // }

    function updatePooler(bool isToAdd, uint256 amount) private {
        uint256 sharesNew;
        if(totalShares == 0){
            sharesNew = amount;//sharePrice == 1
        } else {
            sharesNew = ABDKMathQuadFunc.mulDiv(amount, totalShares, poolBalance);//sharePrice
        }
        uint256 share1 = poolers[msg.sender].shares;
        if(isToAdd) {
            poolers[msg.sender].staking = poolers[msg.sender].staking.add(amount);
            poolers[msg.sender].shares = share1.add(sharesNew);
            totalShares = totalShares.add(amount);
        } else {
            poolers[msg.sender].staking = poolers[msg.sender].staking.sub(amount);
            poolers[msg.sender].shares = share1.sub(sharesNew);
            totalShares = totalShares.sub(amount);
        }
    }

    event Stake(address indexed user, uint256 amount);
    function stake(uint256 amount) external {
        //console.log("[solc] stake amount:", amount);
        token.safeTransferFrom(msg.sender, address(this), amount);

        //to   stake 100 AFI => issues  100/sharePrice shares, +100 AFI in poolBalance
        updatePooler(true, amount);
        //before adding amount to the poolBalance
        poolBalance = poolBalance.add(amount);
        emit Stake(msg.sender, amount);
    }

    event UnStake(address indexed user, uint256 amount);
    function unstake(uint256 amount) external {
        //console.log("[sc] unstake amount:", amount);
        //to unstake 100 AFI => issues -100/sharePrice shares, -100 AFI in poolBalance,
        updatePooler(false, amount);
        //before adding amount to the poolBalance
        poolBalance = poolBalance.sub(amount);
        token.safeTransfer(msg.sender, amount);
        emit UnStake(msg.sender, amount);
    }


    //-----== Governance
    uint256 public govBalance;

    event Harvest(address indexed user, uint256 amount, address indexed toAddr);
    function harvest(uint256 amount) public {
        require(isOnlyGov(), "caller invalid");
        //console.log("[sc] harvest amount:", amount);
        require(vault != address(0), "vault cannot be zero address");
        //require(address(vault).isContract(), "call to non-contract");
        govBalance = govBalance.sub(amount);
        token.safeTransfer(vault, amount);
        emit Harvest(msg.sender, amount, vault);
    }

    //-----------------== 
    // function calcSharePrice() public view returns(uint256) {
    //     //Share price = poolBalance in AFI / total shares, as tokenPerShare
    //     if(totalShares == 0) return 1;//*(10**18);
    //     return ABDKMathQuadFunc.mulDiv(poolBalance, 1, totalShares);
    //     //return poolBalance.div(totalShares);
    // }
    //-----------------== Better
    uint256 public totalBetAmount;
    uint256 public totalDeposits;
    uint256 public totalUnclaimed;
    struct Better {
        uint256 deposit;
        uint256 unclaimed;
    }
    mapping(address => Better) public betters;

    function getDataBetting() external view returns (uint256, uint256, uint256, uint256, uint256, Better memory){
      return (totalBetAmount, totalDeposits, totalUnclaimed, maxTotalUnclaimed(), govBalance, betters[msg.sender]);
    }

    function updateBetterDeposit(bool isToAdd, uint256 amount, address addr) private {
        if(isToAdd) {
            betters[addr].deposit = betters[addr].deposit.add(amount);
        } else {
            betters[addr].deposit = betters[addr].deposit.sub(amount);
        }
    }
    function updateBetterUnclaimed(bool isToAdd, uint256 amount, address user) private {
        if(isToAdd) {
            betters[user].unclaimed = betters[user].unclaimed.add(amount);
        } else {
            betters[user].unclaimed = betters[user].unclaimed.sub(amount);
        }
    }

    event Deposit(address indexed user,uint256 amount);
    function deposit(uint256 amount) external {
        //console.log("[sc] deposit amount:", amount);
        token.safeTransferFrom(msg.sender, address(this), amount);
        totalDeposits = totalDeposits.add(amount);
        updateBetterDeposit(true, amount, msg.sender);
        emit Deposit(msg.sender, amount);
    }
    event Withdraw(address indexed user, uint256 amount);
    function withdraw(uint256 amount) external {
        //console.log("[sc] withdraw amount:", amount);
        updateBetterDeposit(false, amount, msg.sender);
        totalDeposits = totalDeposits.sub(amount);
        token.safeTransfer(msg.sender, amount);
        emit Withdraw(msg.sender, amount);
    }
    event Claim(address indexed user, uint256 amount);
    function claim(uint256 amount) external {
        //console.log("[sc] claim amount:", amount);
        //when a better claims 18.8, the betterBalance and unclaimed balance are both reduced by 18.8
        address user = msg.sender;
        updateBetterUnclaimed(false, amount, user);
        totalUnclaimed = totalUnclaimed.sub(amount);
        token.safeTransfer(user, amount);
        emit Claim(user, amount);
    }


    //-----------------== Get Oracle data
    function getLatestPrices() public view returns (uint256 priceBTC, uint256 priceETH) {
        if (isLivePrice) {
            if (EVMChainID == 100) {
                priceBTC = uint256(BTCUSDpriceFeedXDAI.latestAnswer());
                priceETH = uint256(ETHUSDpriceFeedXDAI.latestAnswer());
            } else if (EVMChainID == 1) {
                // uint80 roundID, int256 price, uint256 startedAt,   uint256 timeStamp, uint80 answeredInRound
                (, int256 int256BTC, , , ) =
                    BTCUSDpriceFeedEtheremV3.latestRoundData();
                priceBTC = uint256(int256BTC);

                (uint80 roundID, int256 int256ETH, , , ) =
                    ETHUSDpriceFeedEtheremV3.latestRoundData();
                priceETH = uint256(int256ETH);
                //console.log("roundID: %s, priceETH: %s", roundID, priceETH);
                //event ErrorEvent(uint80 indexed roundID, int256 price);
            } else {
                //return 0;
            }
        } else {
            priceBTC = fakePriceBTC; //(2681613790994);
            priceETH = fakePriceETH;//(72913790994);
        }
    }
/*BTC
  |int256 :  36893488147419104753
  |int256 :  2681613790994
  |uint256 :  1609153940
  |uint256 :  1609153940
  |uint80 :  36893488147419104753   
ETH
  |int256 :  36893488147419104753
  |int256 :  72913790994
  |uint256 :  1609153940
  |uint256 :  1609153940
  |uint80 :  36893488147419104753  */
    //(roundID, price, startedAt, timeStamp, answeredInRound) = getLatestPriceETH()


    /**
     * Returns historical price for a round id.
     * roundId is NOT incremental. Not all roundIds are valid. You must know a valid roundId before consuming historical data.
     * ROUNDID VALUES:
     *    InValid:      18446744073709562300
     *    Valid:        18446744073709562301
     *
     * @dev A timestamp with zero value means the round is not complete and should not be used.
     */
    // function getHistoricalPrice(uint80 roundId)
    //     public
    //     view
    //     returns (
    //         uint80,
    //         int256,
    //         uint256,
    //         uint256,
    //         uint80
    //     )
    // {
    //     (
    //         uint80 id,
    //         int256 price,
    //         uint256 startedAt,
    //         uint256 timeStamp,
    //         uint80 answeredInRound
    //     ) = BTCUSDpriceFeedEtheremV3.getRoundData(roundId);
    //     require(timeStamp > 0, "Round not complete");
    //     return (id, price, startedAt, timeStamp, answeredInRound);
    // }
}

//pragma solidity >=0.6.0;
//import "https://github.com/smartcontractkit/chainlink/blob/master/evm-contracts/src/v0.6/interfaces/AggregatorV3Interface.sol"
interface AggregatorEthereumV3 {
    function decimals() external view returns (uint8);

    function description() external view returns (string memory);

    function version() external view returns (uint256);

    // getRoundData and latestRoundData should both raise "No data present"
    // if they do not have data to report, instead of returning unset values, which could be misinterpreted as actual reported values.
    function getRoundData(uint80 _roundId)
        external
        view
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        );

    function latestRoundData()
        external
        view
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        );
}

interface AggregatorXDAI {
    function latestAnswer() external view returns (int256);

    function latestTimestamp() external view returns (uint256);

    function latestRound() external view returns (uint256);

    function getAnswer(uint256 roundId) external view returns (int256);

    function getTimestamp(uint256 roundId) external view returns (uint256);

    event AnswerUpdated(
        int256 indexed current,
        uint256 indexed roundId,
        uint256 updatedAt
    );
    event NewRound(
        uint256 indexed roundId,
        address indexed startedBy,
        uint256 startedAt
    );
}

/**
 * MIT License
 * ===========
 *
 * Copyright (c) 2020,2021 Aries Financial
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 */