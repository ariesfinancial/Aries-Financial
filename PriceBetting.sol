/**
 *Submitted for verification at BscScan.com on 2021-04-12
*/

//"SPDX-License-Identifier: MIT"
pragma solidity ^0.8.1;

// import "hardhat/console.sol";

/**
deploy ABDKMathQuadFunc
deploy RoundIdCtrt      ... 2606735  gas
deploy priceBetting     ... 4624304 gas

verify contract
update contract out code
update repo readme with new addresses

change owner of PriceBetting to proper admin

Stake a huge amount

Users approve priceBetting enough token amount<br>
*/

//sol8.0.0
interface IERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);
}

//sol8.0.0
library Address {
    function isContract(address account) internal view returns (bool) {
        uint256 size;
        assembly {size := extcodesize(account)}
        return size > 0;
    }

    //function sendValue(address payable recipient, uint256 amount) internal {...}

    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCall(target, data, "Address: low-level call failed");
    }

    function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    function functionCallWithValue(address target, bytes memory data, uint256 value, string memory errorMessage) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.call{value : value}(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    // functionStaticCall x2
    // functionDelegateCall x2

    function _verifyCallResult(bool success, bytes memory returndata, string memory errorMessage) private pure returns (bytes memory) {
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

//---------------------==
//sol8.0.0
library SafeERC20 {
    using Address for address;

    function safeTransfer(IERC20 token, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }

    function safeTransferFrom(IERC20 token, address from, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }

    // function safeApprove(IERC20 token, address spender, uint256 value) internal {
    //     require((value == 0) || (token.allowance(address(this), spender) == 0),
    //         "SafeERC20: approve from non-zero to non-zero allowance"
    //     );
    //     _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
    // }

    // function safeIncreaseAllowance(IERC20 token, address spender, uint256 value) internal {
    //     uint256 newAllowance = token.allowance(address(this), spender) + value;
    //     _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    // }

    // function safeDecreaseAllowance(IERC20 token, address spender, uint256 value) internal {
    //     unchecked {
    //         uint256 oldAllowance = token.allowance(address(this), spender);
    //         require(oldAllowance >= value, "SafeERC20: decreased allowance below zero");
    //         uint256 newAllowance = oldAllowance - value;
    //         _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    //     }
    // }

    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");
        if (returndata.length > 0) {// Return data is optional
            // solhint-disable-next-line max-line-length
            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
        }
    }
}
/**
    function compare( string memory a, string memory b) public pure returns(bool) { return keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
*/

library SafeMath {
    // function add(uint256 a, uint256 b) internal pure returns (uint256) {
    //     uint256 c = a + b;
    //     require(c >= a, "SafeMath: addition overflow");

    //     return c;
    // }

    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    )
    internal pure
    returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }
}

//----------------------------==
interface IABDKMathQuadFunc {
    function mulMul(
        uint256 x,
        uint256 y,
        uint256 z
    )
    external pure
    returns (uint256);

    function mulDiv(
        uint256 x,
        uint256 y,
        uint256 z
    )
    external pure
    returns (uint256);
}

interface AggregatorEthereumV3 {
    function latestRoundData()
    external view
    returns (
        uint80 roundId,
        int256 answer,
        uint256 startedAt,
        uint256 updatedAt,
        uint80 answeredInRound
    );

    function getRoundData(uint80 _roundId)
    external view
    returns (
        uint80 roundId,
        int256 answer,
        uint256 startedAt,
        uint256 updatedAt,
        uint80 answeredInRound
    );
}

interface IRoundIdCtrt {
    struct RoundIdSet {
        uint256 timestamp;
        uint80 roundIdBTC;
        uint80 roundIdETH;
    }

    function getHistoricalPrice1(uint80 back, uint256 assetId) external view returns (uint256 price, uint80 roundId, uint256 updatedAt);

    function getHistoricalPrice2(uint256 timestamp, uint256 assetId) external view returns (uint256 priceOut, uint256[] memory uintOut, int256[] memory intOut);

    function getHistoricalPrice(uint256 timestamp, uint256 assetId) external view returns (uint256 priceOut, uint256[] memory uintOut, int256[] memory intOut);

    function timeToRoundIds(uint256 timestamp) external view returns (RoundIdSet memory roundIdSet);
}

contract PriceBetting {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;
    using Address for address;

    // Private members
    address private governance;
    address private vault;

    // Public members
    address public owner;
    address public addrToken;
    address public addrPriceFeedBTC;
    address public addrPriceFeedETH;
    address public addrRoundIdCtrt;
    uint public period1;
    uint public period2;
    uint public maxBetAmt = 100 * (10 ** (18));
    uint public profitRatio = 88; // lesser than 100
    uint public maxTotalUnclaimedRatio = 50; // <100
    uint public maxOutLen = 50;
    uint public maxBetsToClear = 3;
    uint public maxSizeOfArray = 5;
    bool public bettingStatus = true;
    mapping(address => uint256) public authLevel;
    mapping(address => Bets) public accounts;
    IABDKMathQuadFunc public ABDKMathQuadFunc;

    enum FundingSource {
        balance,
        wallet
    }

    enum AssetPair {
        bitcoin,
        ethereum
    }

    enum BettingOutcome {
        low,
        high,
        tie
    }

    struct Bet {
        address user;                   // user address
        uint betAt;                     // time this bet was recorded
        uint amount;                    // amount of betting
        uint period;                    // in seconds
        uint priceAtBet;                // the price user bet at that time
        uint settledAt;                 // time this bet was settled
        uint roundId;
        uint settledPrice;              // price this bet was settled
        uint result;                    // betting result that will be update after clearing bet
        bool isSettled;                 // determine if this record has been settled
        AssetPair assetPair;            // 0: BTC, 1: ETH
        BettingOutcome bettingOutcome;  // 0: low, 1: high, 2: tie
        FundingSource fundingSource;    // 0: balance, 1: wallet
    }


    struct Pooler {
        uint256 shares;
        uint256 staking; //in token unit
    }

    struct Bets {
        Bet btc;
        Bet eth;
    }

    constructor(
        address _addrToken,
        address _ABDKMathQuadAddr,
        address _addrPriceFeedBTC,
        address _addrPriceFeedETH,
        address _addrRoundIdCtrt
    )
    {
        owner = msg.sender;
        authLevel[owner] = 9;
        governance = owner;
        vault = owner;

        addrToken = _addrToken;
        ABDKMathQuadFunc = IABDKMathQuadFunc(_ABDKMathQuadAddr);
        addrPriceFeedBTC = _addrPriceFeedBTC;
        addrPriceFeedETH = _addrPriceFeedETH;
        addrRoundIdCtrt = _addrRoundIdCtrt;
        period1 = 3600;
        period2 = 14400;
    }
    /*-----------== BSC Testnet
      addrToken = address(0x9121e7445B4cCD88EF4B509Df17dB029128EbbA0);
      ABDKMathQuadFunc = IABDKMathQuadFunc(0x1331e0a03D7f820c7d1C6676D4cE76DD2b791Cf2);

      addrPriceFeedBTC = address(0x5741306c21795FdCBb9b265Ea0255F499DFe515C);
      addrPriceFeedETH = address(0x143db3CEEfbdfe5631aDD3E50f7614B6ba708BA7);

      -----------== BSC Mainnet
      addrToken = address(0x82D6F82a82d08e08b7619E6C8F139391C23DC539);//AFIv2
      ABDKMathQuadFunc = IABDKMathQuadFunc(0x441FbCa0cE9b475bE04556DDC4d1371db6F65c66);

      addrPriceFeedBTC = address(0x264990fbd0A4796A3E3d8E37C4d5F87a3aCa5Ebf);
      addrPriceFeedETH = address(0x9ef1B8c0E4F7dc8bF5719Ea496883DC6401d5b2e);

    -------------== XDAI
      ABDKMathQuadFunc = IABDKMathQuadFunc(0x1331e0a03D7f820c7d1C6676D4cE76DD2b791Cf2);
      addrToken = address(0xc81c785653D97766b995D867CF91F56367742eAC);
      addrPriceFeedBTC = address(0xC3eFff1B3534Ab5e2Ce626DCF1783b7E83154eF4);
     */

    modifier authorized()
    {
        require(authLevel[msg.sender] > 0, "not authorized");
        _;
    }

    modifier isOwner()
    {
        require(msg.sender == owner, "not owner");
        _;
    }

    event SetOwner(address _owner);
    function setOwner(address _owner)
    external isOwner
    {
        owner = _owner;
        emit SetAdmin(_owner);
    }

    event SetAdmin(address _user);
    function setAdmin(address _user)
    external isOwner
    {
        authLevel[_user] = 1;
        emit SetAdmin(_user);
    }

    event SetSettings(uint256 indexed option, address addr, bool _bool, uint256 uintNum);
    // event SetAccount(address indexed previousAccount, address indexed newAccount, uint256 indexed uintNum);
    event Win(address indexed user, uint256 indexed timestamp, uint256 result, uint256 assetPair);
    event Lose(address indexed user, uint256 indexed timestamp, uint256 result, uint256 assetPair);
    event Tie(address indexed user, uint256 indexed timestamp, uint256 result, uint256 assetPair);
    event BetResult(Bet _bet);

    function isAccount(
        address addr,
        uint256 uintNum
    )
    public view
    returns (bool)
    {
        if (uintNum == 0) return addr == owner;
        if (uintNum == 1) return addr == governance;
        if (uintNum == 2) return authLevel[msg.sender] > 0;
        return false;
    }

    function setSettings(
        uint256 option,
        address addr,
        bool _bool,
        uint256 uintNum
    )
    external authorized
    {
        if (option > 900) {
            require(address(addr).isContract(), "invalid contract");
        }
        if (option == 101) {
            period1 = uintNum;
        } else if (option == 102) {
            period2 = uintNum;

        } else if (option == 103) {
            bettingStatus = _bool;

        } else if (option == 104) {
            require(uintNum >= 1 * (10 ** (15)), "invalid number");
            maxBetAmt = uintNum;

        } else if (option == 105) {
            require(uintNum > 0, "amount cannot be 0");
            maxBetsToClear = uintNum;

        } else if (option == 106) {
            require(uintNum > 0 && uintNum <= 100, "ratio invalid");
            profitRatio = uintNum;

        } else if (option == 107) {
            require(uintNum > 0 && uintNum <= 100, "ratio invalid");
            maxTotalUnclaimedRatio = uintNum;

        } else if (option == 108) {
            require(uintNum > 0, "ratio invalid");
            sharePriceUnit = uintNum;

        } else if (option == 109) {
            require(uintNum > 0, "uintNum must be > 0");
            maxOutLen = uintNum;

        } else if (option == 890) {
            //require(address(token).isContract(), "call to non-contract");
            vault = addr;

        } else if (option == 995) {
            addrRoundIdCtrt = addr;

        } else if (option == 996) {
            addrRoundIdCtrt = addr;

        } else if (option == 997) {//MUST clear all bets before changing token address!!!
            addrToken = addr;
            // } else if(option == 998){
            //   require(address(addr).isContract(),"invalid contract");
            //   addrUserRecord = addr;
        }
        emit SetSettings(option, addr, _bool, uintNum);
    }

    /// @dev Binary option betting function
    /// @param _amount           Token amount user bet
    /// @param _period           Time for predication
    /// @param _assetPair        Asset that user want to bet. 0: bitcoin, 1: ethereum
    /// @param _bettingOutcome   The outcome user predicated. 0: low, 1: high
    /// @param _fundingSource    Where user bet from. 0: balance, 1: wallet
    function enterBet(
        uint _amount,
        uint _period,
        uint _assetPair,
        uint _bettingOutcome,
        uint _fundingSource
    )
    external
    {
        address user = msg.sender;

        if (FundingSource(_fundingSource) == FundingSource.balance) {
            // balance
            updateBetterBalance(false, _amount, user);
        } else {
            // wallet
            IERC20(addrToken).safeTransferFrom(user, address(this), _amount);
        }
        
        Bet memory _bet = getBet(user, _assetPair);
        if (_bet.user != address(0) && !_bet.isSettled) {
            clearBet(user, _assetPair);
        }
        
        createNewBet(
            user,
            _amount,
            _period,
            _assetPair,
            _bettingOutcome,
            _fundingSource
        );
        
    }

    /// @dev Update betting result
    /// @param _user         The msg.sender
    /// @param _assetPair    Asset that user want to bet. 0: bitcoin, 1: ethereum
    /// @param _result       Result that user is win, lose or tie
    /// @param _settledAt    Actual time to judge win or lose.
    /// @param _roundId      The ID records the price at the time of winning or losing
    function updateBet(
        address _user,
        uint _assetPair,
        uint _result,
        uint _settledAt,
        uint _settledPrice,
        uint _roundId
    )
    internal
    {
        AssetPair assetPair = AssetPair(_assetPair);

        require(_user != address(0), "Invalid user address");
        require(assetPair == AssetPair.bitcoin || assetPair == AssetPair.ethereum, "Invalid asset pair");

        if (assetPair == AssetPair.bitcoin) {
            accounts[_user].btc.result = _result;
            accounts[_user].btc.roundId = _roundId;
            accounts[_user].btc.settledAt = _settledAt;
            accounts[_user].btc.settledPrice = _settledPrice;
            accounts[_user].btc.isSettled = true;
            emit BetResult(accounts[_user].btc);
        } else {
            accounts[_user].eth.result = _result;
            accounts[_user].eth.roundId = _roundId;
            accounts[_user].eth.settledAt = _settledAt;
            accounts[_user].eth.settledPrice = _settledPrice;
            accounts[_user].eth.isSettled = true;
            emit BetResult(accounts[_user].eth);
        }
    }

    /// @dev Create a new bet record
    /// @param  _user              The msg.sender
    /// @param  _amount            The AFI token user bet
    /// @param  _period            Period user bet. 0: 1800(30 mins), 1: 3600(60 mins)
    /// @param  _assetPair         The asset user bet. 0: bitcoin, 1: ethereum
    /// @param  _bettingOutcome    The outcome user predicated. 0: low, 1: high, 2: tie
    /// @param  _fundingSource     Where user bet from. 0: balance, 1: wallet
    function createNewBet(
        address _user,
        uint _amount,
        uint _period,
        uint _assetPair,
        uint _bettingOutcome,
        uint _fundingSource
    )
    internal
    {
        Bet memory _bet;
        
        _bet.user = _user;
        _bet.betAt = block.timestamp;
        _bet.amount = _amount;
        _bet.period = _period;
        _bet.assetPair = AssetPair(_assetPair);
        _bet.priceAtBet = getLatestPrice(_assetPair);
        _bet.bettingOutcome = BettingOutcome(_bettingOutcome);
        _bet.fundingSource = FundingSource(_fundingSource);
        
        if (AssetPair(_assetPair) == AssetPair.bitcoin) {
            accounts[_user].btc = _bet;
        } else {
            accounts[_user].eth = _bet;
        }
    }
    
    /// @dev Get current bet infomation
    /// @param  _user       User address
    /// @param  _assetPair  The asset user bet. 0: bitcoin, 1: ethereum
    function getBet(
        address _user,
        uint _assetPair
    )
    public view
    returns(
        Bet memory _bet
    )
    {
        if (AssetPair(_assetPair) == AssetPair.bitcoin) {
            _bet = accounts[_user].btc;
        } else {
            _bet = accounts[_user].eth;
        }
    }
    
    /// @dev Clear current bet by executing judgement function
    /// @param  _user       User address
    /// @param  _assetPair  The asset user bet. 0: bitcoin, 1: ethereum
    function clearBet(
        address _user,
        uint _assetPair
    )
    public
    {
        Bet memory _bet;
        
        if (AssetPair(_assetPair) == AssetPair.bitcoin) {
            _bet = accounts[_user].btc;
        } else {
            _bet = accounts[_user].eth;
        }
        
        if (_bet.user != address(0) && _bet.isSettled == false) {
            settle(_user, _assetPair);
        }
    }

    /// @dev The judgement function for bet
    /// @param  _user       User Address
    /// @param  _assetPair  The bet asset. 0: bitcoin, 1: ethereum
    function settle(
        address _user,
        uint _assetPair
    )
    private
    {
        Bet memory bet = getBet(_user, _assetPair);
        (uint256 price, uint256[] memory uintOut,) = IRoundIdCtrt(addrRoundIdCtrt).getHistoricalPrice(bet.betAt + bet.period, uint256(bet.assetPair));
        uint256 roundId = uintOut[3];

        // console.log("[sc] settle(): priceNow: %s", price);
        // console.log("[sc] priceAtBet: %s, bettingOutcome: %s", bet.priceAtBet, bet.bettingOutcome);

        // amount * 0.88
        uint256 gain = ABDKMathQuadFunc.mulDiv(bet.amount, profitRatio, 100);
        // amount + (amount * 0.88)
        uint256 gaPrin = bet.amount + gain;
        uint256 govGain = bet.amount.sub(gain);

        if (price < bet.priceAtBet) {
            govBalance += govGain;
            if (bet.bettingOutcome == BettingOutcome.low) {
                // console.log("[sc] ----== Win1: price down");
                handleWinning(_user, _assetPair, gain, gaPrin, price, roundId);
            } else {
                // console.log("[sc] ----== Lose1: price down");
                handleLosing(_user, _assetPair, gain, price, roundId);
            }
        } else if (price > bet.priceAtBet) {
            govBalance += govGain;
            if (bet.bettingOutcome == BettingOutcome.high) {
                // console.log("[sc] ----== Win2: price up");
                handleWinning(_user, _assetPair, gain, gaPrin, price, roundId);
            } else {
                // console.log("[sc] ----== Lose2: price up");
                handleLosing(_user, _assetPair, gain, price, roundId);
            }
        } else {
            // console.log("[sc] ----== Same price");
            handleTie(_user, _assetPair, price, roundId);
        }
    }

    /// @dev Winning handler
    function handleWinning(
        address _user,
        uint _assetPair,
        uint _gain,
        uint _gaPrin,
        uint _price,
        uint _roundId
    )
    internal
    {
        // console.log("[sc] ----== handleWinning");
        // console.log(assetPair, gain, gaPrin);
        Bet memory bet = getBet(_user, _assetPair);
        require(poolBalance >= bet.amount, "poolBalance1");
        poolBalance = poolBalance.sub(bet.amount);
        // Pool loses 1
        setSharePrice();
        // after poolBalance updated

        FundingSource fundingSource = FundingSource(bet.fundingSource);

        if (fundingSource == FundingSource.balance) {
            // balance
            totalUnclaimed += _gain;
        } else {
            // wallet
            totalUnclaimed += _gaPrin;
        }
        updateBetterBalance(true, _gaPrin, bet.user);
        updateBetterWinloss(true, _gain, bet.user);

        updateBet(_user, _assetPair, _gaPrin, block.timestamp, _price, _roundId);
        emit Win(bet.user, block.timestamp, _gaPrin, _assetPair);
    }

    /// @dev Losing handler
    function handleLosing(
        address _user,
        uint256 _assetPair,
        uint256 _gain,
        uint256 _price,
        uint256 _roundId
    )
    internal
    {
        Bet memory bet = getBet(_user, _assetPair);
        poolBalance += _gain;
        // Pool gets 0.88
        setSharePrice();
        //after poolBalance updated

        FundingSource fundingSource = FundingSource(bet.fundingSource);

        if (fundingSource == FundingSource.balance) {
            // from balance
            require(totalUnclaimed >= bet.amount, "totalUnclaimed1");
            totalUnclaimed = totalUnclaimed.sub(bet.amount);
        } else {
            // from wallet
            //add 0 in his balance
            //add 0 in totalUnclaimed
        }
        updateBetterWinloss(false, bet.amount, bet.user);
        updateBet(_user, _assetPair, 0, block.timestamp, _price, _roundId);
        emit Lose(bet.user, block.timestamp, 0, _assetPair);
    }
    
    /// @dev Tie handler
    function handleTie(
        address _user,
        uint256 _assetPair,
        uint256 _price,
        uint256 _roundId
    )
    internal
    {
        Bet memory bet = getBet(_user, _assetPair);

        FundingSource fundingSource = FundingSource(bet.fundingSource);

        if (fundingSource == FundingSource.balance) {
            // from balance
            // add 0 in totalUnclaimed
        } else {
            // from wallet
            totalUnclaimed += bet.amount;
        }
        //add 1 in his balance for both cases above
        updateBetterBalance(true, bet.amount, bet.user);

        updateBet(_user, _assetPair, bet.amount, block.timestamp, _price, _roundId);
        emit Tie(bet.user, block.timestamp, bet.amount, _assetPair);
    }

    uint256 public sharePriceUnit = 1000; // 1*(10**9);
    uint256 public sharePrice = sharePriceUnit;
    uint256 public totalShares;
    uint256 public poolBalance;
    mapping(address => Pooler) public poolers;

    event Stake(address indexed user, uint256 amount);

    function stake(
        uint256 amount
    )
    external
    {
        require(amount > 0, "amount1");
        //console.log("[solc] stake amount:", amount);
        IERC20(addrToken).safeTransferFrom(msg.sender, address(this), amount);

        //to   stake 100 AFI => issues  100/sharePrice shares, +100 AFI in poolBalance
        uint256 oldTotalShares = totalShares;
        poolBalance += amount;
        poolers[msg.sender].staking += amount;
        totalShares = ABDKMathQuadFunc.mulDiv(
            poolBalance, sharePriceUnit, sharePrice);
        // newTotalShares = new_poolBalance / shareprice
        // newShares = newTotalShares - oldTotalShares
        // add newShares to this pooler
        poolers[msg.sender].shares += (totalShares.sub(oldTotalShares));
        emit Stake(msg.sender, amount);
    }

    event Unstake(address indexed user, uint256 amount);

    function unstake(
        uint256 _amount
    )
    external
    {
        //console.log("[sc] unstake amount:", amount);
        //to unstake 100 AFI => issues -100/sharePrice shares, -100 AFI in poolBalance,

        (uint256 effPoolerBalance,,,, bool isOk) = checkUnstake(msg.sender, _amount);
        require(isOk, "invalid inputs");

        if (_amount <= poolBalance) {
            //uint256 effPoolerBalance = ABDKMathQuadFunc.mulDiv( poolers[msg.sender].shares, poolBalance, totalShares);
            if (_amount > 0 && _amount <= effPoolerBalance) {
                //win & tie
                if (effPoolerBalance >= poolers[msg.sender].staking && poolers[msg.sender].staking >= _amount) {
                    poolers[msg.sender].staking = poolers[msg.sender].staking.sub(_amount);
                    uint256 oldTotalShares = totalShares;
                    poolBalance = poolBalance.sub(_amount);
                    totalShares = ABDKMathQuadFunc.mulDiv(poolBalance, sharePriceUnit, sharePrice);
                    poolers[msg.sender].shares = poolers[msg.sender].shares.sub(oldTotalShares.sub(totalShares));
                    tokenSafeTransfer(msg.sender, _amount);
                }
                else if (_amount > poolers[msg.sender].staking) {
                    poolers[msg.sender].staking = 0;
                    uint256 oldTotalShares = totalShares;
                    poolBalance = poolBalance.sub(_amount);
                    totalShares = ABDKMathQuadFunc.mulDiv(poolBalance, sharePriceUnit, sharePrice);
                    poolers[msg.sender].shares = poolers[msg.sender].shares.sub(oldTotalShares.sub(totalShares));
                    tokenSafeTransfer(msg.sender, _amount);
                }
                //lose
                else if (poolers[msg.sender].staking > effPoolerBalance) {
                    poolers[msg.sender].staking = poolers[msg.sender].staking.sub(_amount);
                    uint256 oldTotalShares = totalShares;
                    poolBalance = poolBalance.sub(_amount);
                    totalShares = ABDKMathQuadFunc.mulDiv(poolBalance, sharePriceUnit, sharePrice);
                    poolers[msg.sender].shares = poolers[msg.sender].shares.sub(oldTotalShares.sub(totalShares));
                    tokenSafeTransfer(msg.sender, _amount);
                }
            }
        }
    }

    function checkUnstake(
        address _user,
        uint256 _amount
    )
    public view
    returns (
        uint256 effPoolerBalance,
        uint256 amount,
        Pooler memory pooler,
        bool[] memory bools,
        bool isOk
    )
    {
        bools = new bool[](3);
        effPoolerBalance = ABDKMathQuadFunc.mulDiv(poolers[msg.sender].shares, poolBalance, totalShares);
        pooler = poolers[_user];
        amount = _amount;
        bools[0] = amount <= poolBalance;
        bools[1] = amount > 0;
        bools[2] = amount <= effPoolerBalance;

        isOk = bools[0] && bools[1] && bools[2];
    }

    function setSharePrice()
    private
    {
        if (totalShares == 0 || poolBalance == 0) {
            sharePrice = 1 * sharePriceUnit;
        } else {
            sharePrice = ABDKMathQuadFunc.mulDiv(
                poolBalance,
                sharePriceUnit,
                totalShares
            );
        }
    }

    function getDataStaking(
        address user
    )
    public view
    returns (
        uint256,
        uint256,
        uint256,
        Pooler memory,
        uint256,
        uint256
    )
    {
        uint256 effPoolerBalance;
        //int256 winloseBalance
        if (totalShares == 0 || poolBalance == 0) {
            effPoolerBalance = poolers[user].shares;
        } else {
            effPoolerBalance = ABDKMathQuadFunc.mulDiv(
                poolers[user].shares, poolBalance, totalShares);
        }
        return (poolBalance, totalShares,
        getTokenBalance(address(this)), poolers[user], sharePrice, effPoolerBalance);
    }

    //-----------------== Better
    uint256 public totalUnclaimed;

    struct Better {
        uint256 balance;    // unclaimed balance
        int256 winloss;     // win: +0.88 or lose: -1
    }

    mapping(address => Better) public betters;

    function getTokenBalance(
        address addr
    )
    public view
    returns (
        uint256
    )
    {
        return IERC20(addrToken).balanceOf(addr);
    }

    function tokenSafeTransfer(
        address _to,
        uint256 amount
    )
    private
    {
        IERC20(addrToken).safeTransfer(_to, amount);
    }

    function getDataBetting(
        address user
    )
    external view
    returns (
        uint256,
        uint256,
        uint256,
        Better memory,
        uint256,
        uint256,
        uint256
    )
    {
        return (
        totalUnclaimed,
        poolBalance,
        getTokenBalance(address(this)),
        betters[user],
        maxTotalUnclaimedRatio,
        profitRatio,
        maxBetAmt
        );
    }

    function updateBetterBalance(
        bool isToAdd,
        uint256 amount,
        address user
    )
    private
    {
        if (isToAdd) {
            betters[user].balance += amount;
        } else {
            betters[user].balance = betters[user].balance.sub(amount);
        }
    }

    function updateBetterWinloss(
        bool isToAdd,
        uint256 amount,
        address user
    )
    private
    {
        if (isToAdd) {
            betters[user].winloss += int256(amount);
        } else {
            betters[user].winloss -= int256(amount);
        }
    }

    event Withdraw(address indexed user, uint256 amount);

    function withdraw(
        uint256 _amount
    )
    external
    {
        uint256 amount = _amount;
        if (_amount == 0) {
            amount = betters[msg.sender].balance;
        }
        updateBetterBalance(false, amount, msg.sender);
        totalUnclaimed = totalUnclaimed.sub(amount);
        tokenSafeTransfer(msg.sender, amount);
        emit Withdraw(msg.sender, amount);
    }

    //-----== govBalance
    uint256 public govBalance;

    event Harvest(address indexed user, uint256 amount, address indexed toAddr);

    function harvest(
        uint256 _amount
    )
    public
    {
        require(msg.sender == governance, "caller invalid");
        require(vault != address(0), "vault cannot be zero address");
        uint256 amount = _amount;
        if (_amount == 0) {
            amount = govBalance;
        }
        govBalance = govBalance.sub(amount);
        tokenSafeTransfer(vault, amount);
        emit Harvest(msg.sender, amount, vault);
    }

    function getLatestPrice(
        uint256 assetPair
    )
    public view
    returns (
        uint256
    )
    {
        address pricefeed;
        if (assetPair == 0) {
            pricefeed = addrPriceFeedBTC;
        } else {
            pricefeed = addrPriceFeedETH;
        }
        (, int price,,,) = AggregatorEthereumV3(pricefeed).latestRoundData();
        return uint256(price);
    }

    function getHistoricalPrice(
        uint256 assetPair,
        uint256 roundId
    )
    public view
    returns (
        uint256,
        uint256
    )
    {
        address pricefeed;
        if (assetPair == 0) {
            pricefeed = addrPriceFeedBTC;
        } else {
            pricefeed = addrPriceFeedETH;
        }
        (, int price,, uint updatedAt,) = AggregatorEthereumV3(pricefeed).getRoundData(uint80(roundId));
        /*uint80 roundId,
          int256 price,
          uint256 startedAt,
          uint256 updatedAt,
          uint80 answeredInRound
         */
        require(updatedAt > 0, "Round not complete");
        return (updatedAt, uint256(price));
    }
}


/*
*/
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
