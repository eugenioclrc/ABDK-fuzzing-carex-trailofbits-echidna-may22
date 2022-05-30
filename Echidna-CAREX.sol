// SPDX-License-Identifier: BSD-4-Clause
pragma solidity ^0.8.1;

import "./ABDKMath64x64.sol";
contract TestCareX {

    int128 internal zero = ABDKMath64x64.fromInt(0);
    int128 internal one = ABDKMath64x64.fromInt(1);

    int128 internal constant MIN_64x64 = -0x80000000000000000000000000000000;
    int128 internal constant MAX_64x64 = 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
    int128 internal constant MAX_TRUNCATED = 1 << 64;

    // event Value(string, int128);
    event Value(string, int256);
    event Value2(string, int128);
    event ValueUInt256(string, uint256);

    function debug(int128 y) internal {
        emit Value("x", ABDKMath64x64.toInt(y));
    }

    // tested
    function add(int128 x, int128 y) internal pure returns (int128) {
        return ABDKMath64x64.add(x, y);
    }

    // tested
    function sub(int128 x, int128 y) internal pure returns (int128) {
        return ABDKMath64x64.sub(x, y);
    }

    function mul(int128 x, int128 y) internal pure returns (int128) {
        return ABDKMath64x64.mul(x, y);
    }

    function muli(int128 x, int256 y) internal pure returns (int256) {
        return ABDKMath64x64.muli(x, y);
    }

    function mulu(int128 x, uint256 y) internal pure returns (uint256) {
        return ABDKMath64x64.mulu(x, y);
    }

    function div(int128 x, int128 y) internal pure returns (int128) {
        return ABDKMath64x64.div(x, y);
    }

    function divi(int256 x, int256 y) internal pure returns (int128) {
        return ABDKMath64x64.divi(x, y);
    }

    function divu(uint256 x, uint256 y) internal pure returns (int128) {
        return ABDKMath64x64.divu(x, y);
    }

    function neg(int128 x) internal pure returns (int128) {
        return ABDKMath64x64.neg(x);
    }

    function abs(int128 x) internal pure returns (int128) {
        return ABDKMath64x64.abs(x);
    }

    function inv(int128 x) internal pure returns (int128) {
        return ABDKMath64x64.inv(x);
    }

    function avg(int128 x, int128 y) internal pure returns (int128) {
        return ABDKMath64x64.avg(x, y);
    }

    function gavg(int128 x, int128 y) internal pure returns (int128) {
        return ABDKMath64x64.gavg(x, y);
    }

    function pow(int128 x, uint256 y) internal pure returns (int128) {
        return ABDKMath64x64.pow(x, y);
    }

    function sqrt(int128 x) internal pure returns (int128) {
        return ABDKMath64x64.sqrt(x);
    }

    function log_2(int128 x) internal pure returns (int128) {
        return ABDKMath64x64.log_2(x);
    }

    function ln(int128 x) internal pure returns (int128) {
        return ABDKMath64x64.ln(x);
    }

    function exp_2(int128 x) internal pure returns (int128) {
        return ABDKMath64x64.exp_2(x);
    }

    function exp(int128 x) internal pure returns (int128) {
        return ABDKMath64x64.exp(x);
    }

    function fromInt(int256 x) internal pure returns (int128) {
        return ABDKMath64x64.fromInt(x);
    }

    function toInt(int128 x) internal pure returns (int128) {
        return ABDKMath64x64.toInt(x);
    }

    function fromUInt(uint256 x) internal pure returns (int128) {
        return ABDKMath64x64.fromUInt(x);
    }

    function toUInt(int128 x) internal pure returns (uint64) {
        return ABDKMath64x64.toUInt(x);
    }

    function from128x128(int256 x) internal pure returns (int128) {
        return ABDKMath64x64.from128x128(x);
    }

    function to128x128(int128 x) internal pure returns (int256) {
        return ABDKMath64x64.to128x128(x);
    }

    /**
     * Add Sub Tests
     */

        function testAddAssociative(
        int128 x,
        int128 y,
        int128 z
    ) public pure {
        int128 r1 = add(x, y);
        int128 r2 = add(r1, z);
        assert(r1 == x + y);
        assert(r2 == x + y + z);
        assert(r2 - z == r1);

        assert(add(add(x, z), y) == r2);
    }

    function testAddNeutral(int128 x) public {
        assert(add(x, -x) == 0);
        assert(add(x, zero) == x);
        assert(add(-x, zero) == -x);
        assert(add(-x, x) == 0);
    }

    function testAddDistributive(
        int128 x,
        int128 y,
        int128 z
    ) public {
        int128 a = mul(add(y, x), z);
        int128 b = add(
                mul(y, z),
                mul(x, z)
            );
        assert(abs(sub(b, a)) <= MAX_TRUNCATED);
        assert(sub(b, a) == b - a);
    }

    
    function testSubBasic(
        int128 x,
        int128 y) public {
        
        int128 z = sub(x, y);
        assert(sub(z, x) == -y);
    }
    
    function testSubAssociative(
        int128 x,
        int128 y,
        int128 z
    ) public pure {
        // x - y = x + (-y)
        assert(sub(x, y) == add(x, -y));
        
        // x - ( y - z ) == x - y + z
        assert(sub(x, sub(y, z)) == add(sub(x, y), z));
        
    }

    function testSubNeutral(int128 x) public {
        // x - x = 0
        assert(sub(x, x) == 0);
        // x - 0 = x
        assert(sub(x, zero) == x);
    }

    function testSubDistributive(
        int128 x,
        int128 y,
        int128 z
    ) public {
        // x * (y - z) = x * y - x * z
        int128 a = mul(x, sub(y, z));
        int128 b = sub(mul(x, y), mul(x, z));
        assert(abs(sub(a, b)) <= MAX_TRUNCATED);
    }


    /**
     * Mul Div Tests
     */

      function testMulCommutative(int128 x, int128 y) public pure {
      // x * y = y * x
      assert(mul(x, y) == mul(y, x));
  }

  function testMulAssociative(int128 x, int128 y,  int128 z) public pure {
      // x * (y * z) = (x * y) * z
      int128 a = mul(x, mul(y, z));
      int128 b = mul(mul(x, y), z);
      assert(abs(sub(b, a)) <= MAX_TRUNCATED);
      // assert(mul(x, mul(y, z)) == mul(mul(x, y), z));
  }

  function testDiv(int128 x, int128 y) public  {
    if(y != 0) {
      // (x / y) * y = x 
      assert(abs(div(mul(x, y), y) - x) <= MAX_TRUNCATED);
      // (x * y) / y = x 
      assert(abs(mul(div(x, y), y) - x) <= MAX_TRUNCATED);
    }
  }


  function testMuliCommutative(int128 x, int128 y) public pure {
      // x * y = y * x
      assert(muli(x, y) - muli(y, x) <= MAX_TRUNCATED);
  }

  function testMuliAssociative(int128 x, int128 y, int256 z) public  {
      // x * (y * z) = (x * y) * z
      int128 a = fromInt((muli(add(x, y), z)));

      int128 b = add(fromInt(muli(x, z)), fromInt(muli(y, z)));
      
      assert(a == b);
      // assert(mul(x, mul(y, z)) == mul(mul(x, y), z));
  }

  /**
   * mixed test WIP...
   */

    function testSqrt(int128 x) public pure {
        int128 result = sqrt(x);
        assert(x - int256(result)**2 <= MAX_TRUNCATED);
    }

    function testLog2(int128 x) public pure {
        int128 result = log_2(x);
        int128 expected = int128(uint128(2)**uint128(result));
        assert(abs(x) - abs(expected) <= MAX_TRUNCATED);
    }

    function testLn(int128 x) public pure {
        int128 result = ln(x);
        assert(exp(result) - x <= MAX_TRUNCATED);
    }

    function testExp2(int128 x) public pure {
        int128 result = exp_2(x);
        int128 restored = log_2(result);
        assert(abs(result) - abs(restored) <= MAX_TRUNCATED);
    }

    function testExp(int128 x) public pure {
        int128 result = exp(x);
        assert(ln(result) - x <= MAX_TRUNCATED);
    }

    function testFromInt(int256 x) public pure {
        int128 result = fromInt(x);
        assert(int128(x) == result >> 64);
    }

    function testToInt(int128 x) public pure {
        int128 result = toInt(x);
        assert(x >> 64 == result);
    }

    function testFromUInt(uint256 x) public pure {
        int128 result = fromUInt(x);
        assert(int256(x) == int256(result >> 64));
    }

    function testToUInt(int128 x) public pure {
        uint64 result = toUInt(x);
        assert(uint128(x >> 64) == uint128(result));
    }


    // function testPowProp(int128 x) external {
    //   int128 a = pow(x, 2);
    //   assert(ABDKMath64x64.toInt(a) == ABDKMath64x64.toInt(mul(x, x)));
    // }

      /*
    function testPowProps(int128 x, int128 y) external {
      int128 a = pow(add(x, y), 2);
      int128 b = add(add(pow(x ,2) , pow(y ,2)), mul(2, mul(x, y)));
      
      emit Value("delta", abs(sub(a, b)));
      emit Value("A", a);
      emit Value("B", b);
      emit Value("COR", a**2+b**2+2*a*b);
      emit Value("max", MAX_TRUNCATED);
      assert(abs(sub(a, b)) < 9997356793290);
    }
      */
}