import XCTest
@testable import CodableCode

final class CodableCodeTests: XCTestCase {
    func testEmptyJSON() throws {
        XCTAssertEqual("".codableCode, nil)
    }
    
    func testA() {
        test(
        """
        {
          "success": true,
          "payload": [
            {
              "book": "btc_mxn",
              "minimum_price": "40000",
              "maximum_price": "20000000",
              "minimum_amount": "0.00000030000",
              "maximum_amount": "3000",
              "minimum_value": "10.00",
              "maximum_value": "200000000",
              "tick_size": "10",
              "default_chart": "tradingview",
              "fees": {
                "flat_rate": {
                  "maker": "0.005",
                  "taker": "0.0065"
                },
                "structure": [
                  {
                    "volume": "1500000",
                    "maker": "0.005",
                    "taker": "0.0065"
                  },
                  {
                    "volume": "2000000",
                    "maker": "0.00490",
                    "taker": "0.00637"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00480",
                    "taker": "0.00624"
                  },
                  {
                    "volume": "7000000",
                    "maker": "0.00440",
                    "taker": "0.00572"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00420",
                    "taker": "0.00546"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.00400",
                    "taker": "0.00520"
                  },
                  {
                    "volume": "35000000",
                    "maker": "0.00370",
                    "taker": "0.00481"
                  },
                  {
                    "volume": "50000000",
                    "maker": "0.00300",
                    "taker": "0.00390"
                  },
                  {
                    "volume": "150000000",
                    "maker": "0.00200",
                    "taker": "0.00260"
                  },
                  {
                    "volume": "250000000",
                    "maker": "0.00100",
                    "taker": "0.00130"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0.00000",
                    "taker": "0.00130"
                  }
                ]
              }
            },
            {
              "book": "eth_btc",
              "minimum_price": "0.003",
              "maximum_price": "1.00",
              "minimum_amount": "0.00000400000",
              "maximum_amount": "4000.00",
              "minimum_value": "0.00001000",
              "maximum_value": "300.00",
              "tick_size": "0.000001",
              "default_chart": "tradingview",
              "fees": {
                "flat_rate": {
                  "maker": "0.00075",
                  "taker": "0.00098"
                },
                "structure": [
                  {
                    "volume": "8",
                    "maker": "0.00075",
                    "taker": "0.00098"
                  },
                  {
                    "volume": "10",
                    "maker": "0.00072",
                    "taker": "0.00094"
                  },
                  {
                    "volume": "18",
                    "maker": "0.00071",
                    "taker": "0.00092"
                  },
                  {
                    "volume": "30",
                    "maker": "0.00070",
                    "taker": "0.00091"
                  },
                  {
                    "volume": "45",
                    "maker": "0.00067",
                    "taker": "0.00087"
                  },
                  {
                    "volume": "65",
                    "maker": "0.00065",
                    "taker": "0.00085"
                  },
                  {
                    "volume": "180",
                    "maker": "0.00063",
                    "taker": "0.00082"
                  },
                  {
                    "volume": "500",
                    "maker": "0.00059",
                    "taker": "0.00077"
                  },
                  {
                    "volume": "950",
                    "maker": "0.00055",
                    "taker": "0.00072"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0.00050",
                    "taker": "0.00065"
                  }
                ]
              }
            },
            {
              "book": "eth_mxn",
              "minimum_price": "3000",
              "maximum_price": "1000000.00",
              "minimum_amount": "0.00000400000",
              "maximum_amount": "4000.00",
              "minimum_value": "10.00000000",
              "maximum_value": "200000000.00",
              "tick_size": "1",
              "default_chart": "tradingview",
              "fees": {
                "flat_rate": {
                  "maker": "0.005",
                  "taker": "0.0065"
                },
                "structure": [
                  {
                    "volume": "1500000",
                    "maker": "0.005",
                    "taker": "0.0065"
                  },
                  {
                    "volume": "2000000",
                    "maker": "0.00490",
                    "taker": "0.00637"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00480",
                    "taker": "0.00624"
                  },
                  {
                    "volume": "7000000",
                    "maker": "0.00440",
                    "taker": "0.00572"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00420",
                    "taker": "0.00546"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.00400",
                    "taker": "0.00520"
                  },
                  {
                    "volume": "35000000",
                    "maker": "0.00370",
                    "taker": "0.00481"
                  },
                  {
                    "volume": "50000000",
                    "maker": "0.00300",
                    "taker": "0.00390"
                  },
                  {
                    "volume": "150000000",
                    "maker": "0.00200",
                    "taker": "0.00260"
                  },
                  {
                    "volume": "250000000",
                    "maker": "0.00100",
                    "taker": "0.00130"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0.00000",
                    "taker": "0.00130"
                  }
                ]
              }
            },
            {
              "book": "xrp_btc",
              "minimum_price": "0.0000008",
              "maximum_price": "0.0003",
              "minimum_amount": "0.02000000000",
              "maximum_amount": "20000000.00",
              "minimum_value": "0.00001000",
              "maximum_value": "300.00",
              "tick_size": "0.00000001",
              "default_chart": "tradingview",
              "fees": {
                "flat_rate": {
                  "maker": "0.00075",
                  "taker": "0.00098"
                },
                "structure": [
                  {
                    "volume": "8",
                    "maker": "0.00075",
                    "taker": "0.00098"
                  },
                  {
                    "volume": "10",
                    "maker": "0.00072",
                    "taker": "0.00094"
                  },
                  {
                    "volume": "18",
                    "maker": "0.00071",
                    "taker": "0.00092"
                  },
                  {
                    "volume": "30",
                    "maker": "0.00070",
                    "taker": "0.00091"
                  },
                  {
                    "volume": "45",
                    "maker": "0.00067",
                    "taker": "0.00087"
                  },
                  {
                    "volume": "65",
                    "maker": "0.00065",
                    "taker": "0.00085"
                  },
                  {
                    "volume": "180",
                    "maker": "0.00063",
                    "taker": "0.00082"
                  },
                  {
                    "volume": "500",
                    "maker": "0.00059",
                    "taker": "0.00077"
                  },
                  {
                    "volume": "950",
                    "maker": "0.00055",
                    "taker": "0.00072"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0.00050",
                    "taker": "0.00065"
                  }
                ]
              }
            },
            {
              "book": "xrp_mxn",
              "minimum_price": "0.6",
              "maximum_price": "300",
              "minimum_amount": "0.0200000",
              "maximum_amount": "20000000",
              "minimum_value": "10.00",
              "maximum_value": "200000000",
              "tick_size": "0.0001",
              "default_chart": "tradingview",
              "fees": {
                "flat_rate": {
                  "maker": "0.005",
                  "taker": "0.006500"
                },
                "structure": [
                  {
                    "volume": "1500000",
                    "maker": "0.005",
                    "taker": "0.006500"
                  },
                  {
                    "volume": "2000000",
                    "maker": "0.0049",
                    "taker": "0.006370"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.0048",
                    "taker": "0.006240"
                  },
                  {
                    "volume": "7000000",
                    "maker": "0.0044",
                    "taker": "0.005720"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.0042",
                    "taker": "0.005460"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.004",
                    "taker": "0.005200"
                  },
                  {
                    "volume": "35000000",
                    "maker": "0.0037",
                    "taker": "0.004810"
                  },
                  {
                    "volume": "50000000",
                    "maker": "0.003",
                    "taker": "0.003900"
                  },
                  {
                    "volume": "150000000",
                    "maker": "0.002",
                    "taker": "0.002600"
                  },
                  {
                    "volume": "100000000000",
                    "maker": "0.001",
                    "taker": "0.001300"
                  }
                ]
              }
            },
            {
              "book": "ltc_btc",
              "minimum_price": "0.0001",
              "maximum_price": "0.06",
              "minimum_amount": "0.0000900",
              "maximum_amount": "90000",
              "minimum_value": "0.00001",
              "maximum_value": "300",
              "tick_size": "0.0000001",
              "default_chart": "tradingview",
              "fees": {
                "flat_rate": {
                  "maker": "0.00075",
                  "taker": "0.00098"
                },
                "structure": [
                  {
                    "volume": "8",
                    "maker": "0.00075",
                    "taker": "0.00098"
                  },
                  {
                    "volume": "10",
                    "maker": "0.00072",
                    "taker": "0.00094"
                  },
                  {
                    "volume": "18",
                    "maker": "0.00071",
                    "taker": "0.00092"
                  },
                  {
                    "volume": "30",
                    "maker": "0.00070",
                    "taker": "0.00091"
                  },
                  {
                    "volume": "45",
                    "maker": "0.00067",
                    "taker": "0.00087"
                  },
                  {
                    "volume": "65",
                    "maker": "0.00065",
                    "taker": "0.00085"
                  },
                  {
                    "volume": "180",
                    "maker": "0.00063",
                    "taker": "0.00082"
                  },
                  {
                    "volume": "500",
                    "maker": "0.00059",
                    "taker": "0.00077"
                  },
                  {
                    "volume": "950",
                    "maker": "0.00055",
                    "taker": "0.00072"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0.00050",
                    "taker": "0.00065"
                  }
                ]
              }
            },
            {
              "book": "ltc_mxn",
              "minimum_price": "100",
              "maximum_price": "50000",
              "minimum_amount": "0.0000900",
              "maximum_amount": "90000",
              "minimum_value": "10.00000",
              "maximum_value": "200000000",
              "tick_size": "0.1",
              "default_chart": "tradingview",
              "fees": {
                "flat_rate": {
                  "maker": "0.005",
                  "taker": "0.0065"
                },
                "structure": [
                  {
                    "volume": "1500000",
                    "maker": "0.005",
                    "taker": "0.0065"
                  },
                  {
                    "volume": "2000000",
                    "maker": "0.00490",
                    "taker": "0.00637"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00480",
                    "taker": "0.00624"
                  },
                  {
                    "volume": "7000000",
                    "maker": "0.00440",
                    "taker": "0.00572"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00420",
                    "taker": "0.00546"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.00400",
                    "taker": "0.00520"
                  },
                  {
                    "volume": "35000000",
                    "maker": "0.00370",
                    "taker": "0.00481"
                  },
                  {
                    "volume": "50000000",
                    "maker": "0.00300",
                    "taker": "0.00390"
                  },
                  {
                    "volume": "150000000",
                    "maker": "0.00200",
                    "taker": "0.00260"
                  },
                  {
                    "volume": "250000000",
                    "maker": "0.00100",
                    "taker": "0.00130"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0.00000",
                    "taker": "0.00130"
                  }
                ]
              }
            },
            {
              "book": "bch_btc",
              "minimum_price": "0.0004",
              "maximum_price": "0.2",
              "minimum_amount": "0.0000300",
              "maximum_amount": "30000",
              "minimum_value": "0.00001",
              "maximum_value": "300",
              "tick_size": "0.0000001",
              "default_chart": "tradingview",
              "fees": {
                "flat_rate": {
                  "maker": "0.00075",
                  "taker": "0.00098"
                },
                "structure": [
                  {
                    "volume": "8",
                    "maker": "0.00075",
                    "taker": "0.00098"
                  },
                  {
                    "volume": "10",
                    "maker": "0.00072",
                    "taker": "0.00094"
                  },
                  {
                    "volume": "18",
                    "maker": "0.00071",
                    "taker": "0.00092"
                  },
                  {
                    "volume": "30",
                    "maker": "0.00070",
                    "taker": "0.00091"
                  },
                  {
                    "volume": "45",
                    "maker": "0.00067",
                    "taker": "0.00087"
                  },
                  {
                    "volume": "65",
                    "maker": "0.00065",
                    "taker": "0.00085"
                  },
                  {
                    "volume": "180",
                    "maker": "0.00063",
                    "taker": "0.00082"
                  },
                  {
                    "volume": "500",
                    "maker": "0.00059",
                    "taker": "0.00077"
                  },
                  {
                    "volume": "950",
                    "maker": "0.00055",
                    "taker": "0.00072"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0.00050",
                    "taker": "0.00065"
                  }
                ]
              }
            },
            {
              "book": "bch_mxn",
              "minimum_price": "300",
              "maximum_price": "100000",
              "minimum_amount": "0.0000300",
              "maximum_amount": "30000",
              "minimum_value": "10.00000",
              "maximum_value": "200000000",
              "tick_size": "0.1",
              "default_chart": "tradingview",
              "fees": {
                "flat_rate": {
                  "maker": "0.005",
                  "taker": "0.0065"
                },
                "structure": [
                  {
                    "volume": "1500000",
                    "maker": "0.005",
                    "taker": "0.0065"
                  },
                  {
                    "volume": "2000000",
                    "maker": "0.00490",
                    "taker": "0.00637"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00480",
                    "taker": "0.00624"
                  },
                  {
                    "volume": "7000000",
                    "maker": "0.00440",
                    "taker": "0.00572"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00420",
                    "taker": "0.00546"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.00400",
                    "taker": "0.00520"
                  },
                  {
                    "volume": "35000000",
                    "maker": "0.00370",
                    "taker": "0.00481"
                  },
                  {
                    "volume": "50000000",
                    "maker": "0.00300",
                    "taker": "0.00390"
                  },
                  {
                    "volume": "150000000",
                    "maker": "0.00200",
                    "taker": "0.00260"
                  },
                  {
                    "volume": "250000000",
                    "maker": "0.00100",
                    "taker": "0.00130"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0.00000",
                    "taker": "0.00130"
                  }
                ]
              }
            },
            {
              "book": "tusd_btc",
              "minimum_price": "0.000001",
              "maximum_price": "0.0005",
              "minimum_amount": "0.0100000",
              "maximum_amount": "10000000",
              "minimum_value": "0.00001",
              "maximum_value": "300",
              "tick_size": "0.00000001",
              "default_chart": "tradingview",
              "fees": {
                "flat_rate": {
                  "maker": "0.00075",
                  "taker": "0.00098"
                },
                "structure": [
                  {
                    "volume": "8",
                    "maker": "0.00075",
                    "taker": "0.00098"
                  },
                  {
                    "volume": "10",
                    "maker": "0.00072",
                    "taker": "0.00094"
                  },
                  {
                    "volume": "18",
                    "maker": "0.00071",
                    "taker": "0.00092"
                  },
                  {
                    "volume": "30",
                    "maker": "0.00070",
                    "taker": "0.00091"
                  },
                  {
                    "volume": "45",
                    "maker": "0.00067",
                    "taker": "0.00087"
                  },
                  {
                    "volume": "65",
                    "maker": "0.00065",
                    "taker": "0.00085"
                  },
                  {
                    "volume": "180",
                    "maker": "0.00063",
                    "taker": "0.00082"
                  },
                  {
                    "volume": "500",
                    "maker": "0.00059",
                    "taker": "0.00077"
                  },
                  {
                    "volume": "950",
                    "maker": "0.00055",
                    "taker": "0.00072"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0.00050",
                    "taker": "0.00065"
                  }
                ]
              }
            },
            {
              "book": "tusd_mxn",
              "minimum_price": "1",
              "maximum_price": "400",
              "minimum_amount": "0.0100000",
              "maximum_amount": "10000000",
              "minimum_value": "10.00000",
              "maximum_value": "200000000",
              "tick_size": "0.01",
              "default_chart": "tradingview",
              "fees": {
                "flat_rate": {
                  "maker": "0.005",
                  "taker": "0.0065"
                },
                "structure": [
                  {
                    "volume": "1500000",
                    "maker": "0.005",
                    "taker": "0.0065"
                  },
                  {
                    "volume": "2000000",
                    "maker": "0.00490",
                    "taker": "0.00637"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00480",
                    "taker": "0.00624"
                  },
                  {
                    "volume": "7000000",
                    "maker": "0.00440",
                    "taker": "0.00572"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00420",
                    "taker": "0.00546"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.00400",
                    "taker": "0.00520"
                  },
                  {
                    "volume": "35000000",
                    "maker": "0.00370",
                    "taker": "0.00481"
                  },
                  {
                    "volume": "50000000",
                    "maker": "0.00300",
                    "taker": "0.00390"
                  },
                  {
                    "volume": "150000000",
                    "maker": "0.00200",
                    "taker": "0.00260"
                  },
                  {
                    "volume": "250000000",
                    "maker": "0.00100",
                    "taker": "0.00130"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0.00000",
                    "taker": "0.00130"
                  }
                ]
              }
            },
            {
              "book": "mana_btc",
              "minimum_price": "0.000003",
              "maximum_price": "0.001",
              "minimum_amount": "0.0050000",
              "maximum_amount": "5000000",
              "minimum_value": "0.00001",
              "maximum_value": "300",
              "tick_size": "0.00000001",
              "default_chart": "tradingview",
              "fees": {
                "flat_rate": {
                  "maker": "0.00075",
                  "taker": "0.00098"
                },
                "structure": [
                  {
                    "volume": "8",
                    "maker": "0.00075",
                    "taker": "0.00098"
                  },
                  {
                    "volume": "10",
                    "maker": "0.00072",
                    "taker": "0.00094"
                  },
                  {
                    "volume": "18",
                    "maker": "0.00071",
                    "taker": "0.00092"
                  },
                  {
                    "volume": "30",
                    "maker": "0.00070",
                    "taker": "0.00091"
                  },
                  {
                    "volume": "45",
                    "maker": "0.00067",
                    "taker": "0.00087"
                  },
                  {
                    "volume": "65",
                    "maker": "0.00065",
                    "taker": "0.00085"
                  },
                  {
                    "volume": "180",
                    "maker": "0.00063",
                    "taker": "0.00082"
                  },
                  {
                    "volume": "500",
                    "maker": "0.00059",
                    "taker": "0.00077"
                  },
                  {
                    "volume": "950",
                    "maker": "0.00055",
                    "taker": "0.00072"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0.00050",
                    "taker": "0.00065"
                  }
                ]
              }
            },
            {
              "book": "mana_mxn",
              "minimum_price": "2",
              "maximum_price": "900",
              "minimum_amount": "0.0050000",
              "maximum_amount": "5000000",
              "minimum_value": "10.00000",
              "maximum_value": "200000000",
              "tick_size": "0.01",
              "default_chart": "tradingview",
              "fees": {
                "flat_rate": {
                  "maker": "0.005",
                  "taker": "0.0065"
                },
                "structure": [
                  {
                    "volume": "1500000",
                    "maker": "0.005",
                    "taker": "0.0065"
                  },
                  {
                    "volume": "2000000",
                    "maker": "0.00490",
                    "taker": "0.00637"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00480",
                    "taker": "0.00624"
                  },
                  {
                    "volume": "7000000",
                    "maker": "0.00440",
                    "taker": "0.00572"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00420",
                    "taker": "0.00546"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.00400",
                    "taker": "0.00520"
                  },
                  {
                    "volume": "35000000",
                    "maker": "0.00370",
                    "taker": "0.00481"
                  },
                  {
                    "volume": "50000000",
                    "maker": "0.00300",
                    "taker": "0.00390"
                  },
                  {
                    "volume": "150000000",
                    "maker": "0.00200",
                    "taker": "0.00260"
                  },
                  {
                    "volume": "250000000",
                    "maker": "0.00100",
                    "taker": "0.00130"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0.00000",
                    "taker": "0.00130"
                  }
                ]
              }
            },
            {
              "book": "bat_btc",
              "minimum_price": "0.000001",
              "maximum_price": "0.0004",
              "minimum_amount": "0.0100000",
              "maximum_amount": "10000000",
              "minimum_value": "0.00001",
              "maximum_value": "300",
              "tick_size": "0.00000001",
              "default_chart": "tradingview",
              "fees": {
                "flat_rate": {
                  "maker": "0.00075",
                  "taker": "0.00098"
                },
                "structure": [
                  {
                    "volume": "8",
                    "maker": "0.00075",
                    "taker": "0.00098"
                  },
                  {
                    "volume": "10",
                    "maker": "0.00072",
                    "taker": "0.00094"
                  },
                  {
                    "volume": "18",
                    "maker": "0.00071",
                    "taker": "0.00092"
                  },
                  {
                    "volume": "30",
                    "maker": "0.00070",
                    "taker": "0.00091"
                  },
                  {
                    "volume": "45",
                    "maker": "0.00067",
                    "taker": "0.00087"
                  },
                  {
                    "volume": "65",
                    "maker": "0.00065",
                    "taker": "0.00085"
                  },
                  {
                    "volume": "180",
                    "maker": "0.00063",
                    "taker": "0.00082"
                  },
                  {
                    "volume": "500",
                    "maker": "0.00059",
                    "taker": "0.00077"
                  },
                  {
                    "volume": "950",
                    "maker": "0.00055",
                    "taker": "0.00072"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0.00050",
                    "taker": "0.00065"
                  }
                ]
              }
            },
            {
              "book": "bat_mxn",
              "minimum_price": "0.9",
              "maximum_price": "300",
              "minimum_amount": "0.0100000",
              "maximum_amount": "10000000",
              "minimum_value": "10.00000",
              "maximum_value": "200000000",
              "tick_size": "0.01",
              "default_chart": "tradingview",
              "fees": {
                "flat_rate": {
                  "maker": "0.005",
                  "taker": "0.0065"
                },
                "structure": [
                  {
                    "volume": "1500000",
                    "maker": "0.005",
                    "taker": "0.0065"
                  },
                  {
                    "volume": "2000000",
                    "maker": "0.00490",
                    "taker": "0.00637"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00480",
                    "taker": "0.00624"
                  },
                  {
                    "volume": "7000000",
                    "maker": "0.00440",
                    "taker": "0.00572"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00420",
                    "taker": "0.00546"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.00400",
                    "taker": "0.00520"
                  },
                  {
                    "volume": "35000000",
                    "maker": "0.00370",
                    "taker": "0.00481"
                  },
                  {
                    "volume": "50000000",
                    "maker": "0.00300",
                    "taker": "0.00390"
                  },
                  {
                    "volume": "150000000",
                    "maker": "0.00200",
                    "taker": "0.00260"
                  },
                  {
                    "volume": "250000000",
                    "maker": "0.00100",
                    "taker": "0.00130"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0.00000",
                    "taker": "0.00130"
                  }
                ]
              }
            },
            {
              "book": "btc_ars",
              "minimum_price": "400000",
              "maximum_price": "200000000",
              "minimum_amount": "0.0000003",
              "maximum_amount": "300",
              "minimum_value": "100",
              "maximum_value": "2000000000",
              "tick_size": "100",
              "default_chart": "tradingview",
              "fees": {
                "flat_rate": {
                  "maker": "0.003",
                  "taker": "0.006"
                },
                "structure": [
                  {
                    "volume": "650000",
                    "maker": "0.003",
                    "taker": "0.006"
                  },
                  {
                    "volume": "2600000",
                    "maker": "0.00300",
                    "taker": "0.00550"
                  },
                  {
                    "volume": "6500000",
                    "maker": "0.00250",
                    "taker": "0.00500"
                  },
                  {
                    "volume": "13000000",
                    "maker": "0.00250",
                    "taker": "0.00450"
                  },
                  {
                    "volume": "65000000",
                    "maker": "0.00175",
                    "taker": "0.00400"
                  },
                  {
                    "volume": "130000000",
                    "maker": "0.00085",
                    "taker": "0.00350"
                  },
                  {
                    "volume": "325000000",
                    "maker": "0.00080",
                    "taker": "0.00300"
                  },
                  {
                    "volume": "1300000000",
                    "maker": "0.00080",
                    "taker": "0.00250"
                  },
                  {
                    "volume": "2600000000",
                    "maker": "0.00080",
                    "taker": "0.00200"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0.00080",
                    "taker": "0.00150"
                  }
                ]
              }
            },
            {
              "book": "btc_dai",
              "minimum_price": "2000",
              "maximum_price": "800000",
              "minimum_amount": "0.0000003",
              "maximum_amount": "300",
              "minimum_value": "0.50000",
              "maximum_value": "10000000",
              "tick_size": "1",
              "default_chart": "tradingview",
              "fees": {
                "flat_rate": {
                  "maker": "0.0025",
                  "taker": "0.003"
                },
                "structure": [
                  {
                    "volume": "40000",
                    "maker": "0.0025",
                    "taker": "0.003"
                  },
                  {
                    "volume": "52000",
                    "maker": "0.00240",
                    "taker": "0.00260"
                  },
                  {
                    "volume": "130000",
                    "maker": "0.00210",
                    "taker": "0.00250"
                  },
                  {
                    "volume": "180000",
                    "maker": "0.00200",
                    "taker": "0.00220"
                  },
                  {
                    "volume": "260000",
                    "maker": "0.00180",
                    "taker": "0.00200"
                  },
                  {
                    "volume": "390000",
                    "maker": "0.00160",
                    "taker": "0.00180"
                  },
                  {
                    "volume": "910000",
                    "maker": "0.00150",
                    "taker": "0.00160"
                  },
                  {
                    "volume": "5200000",
                    "maker": "0.00100",
                    "taker": "0.00140"
                  },
                  {
                    "volume": "19500000",
                    "maker": "0.00090",
                    "taker": "0.00130"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0.00080",
                    "taker": "0.00100"
                  }
                ]
              }
            },
            {
              "book": "dai_mxn",
              "minimum_price": "1",
              "maximum_price": "400",
              "minimum_amount": "0.0100000",
              "maximum_amount": "10000000",
              "minimum_value": "10.00000",
              "maximum_value": "200000000",
              "tick_size": "0.01",
              "default_chart": "tradingview",
              "fees": {
                "flat_rate": {
                  "maker": "0.005",
                  "taker": "0.0065"
                },
                "structure": [
                  {
                    "volume": "1500000",
                    "maker": "0.005",
                    "taker": "0.0065"
                  },
                  {
                    "volume": "2000000",
                    "maker": "0.00490",
                    "taker": "0.00637"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00480",
                    "taker": "0.00624"
                  },
                  {
                    "volume": "7000000",
                    "maker": "0.00440",
                    "taker": "0.00572"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00420",
                    "taker": "0.00546"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.00400",
                    "taker": "0.00520"
                  },
                  {
                    "volume": "35000000",
                    "maker": "0.00370",
                    "taker": "0.00481"
                  },
                  {
                    "volume": "50000000",
                    "maker": "0.00300",
                    "taker": "0.00390"
                  },
                  {
                    "volume": "150000000",
                    "maker": "0.00200",
                    "taker": "0.00260"
                  },
                  {
                    "volume": "250000000",
                    "maker": "0.00100",
                    "taker": "0.00130"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0.00000",
                    "taker": "0.00130"
                  }
                ]
              }
            },
            {
              "book": "btc_usd",
              "minimum_price": "2000",
              "maximum_price": "700000",
              "minimum_amount": "0.0000003",
              "maximum_amount": "300",
              "minimum_value": "0.50000",
              "maximum_value": "10000000",
              "tick_size": "1",
              "default_chart": "tradingview",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.00090",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00085",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.00080",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.00090"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00070",
                    "taker": "0.00080"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.00060",
                    "taker": "0.00070"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.00050",
                    "taker": "0.00060"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.00040",
                    "taker": "0.00050"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0.0000",
                    "taker": "0.00040"
                  }
                ]
              }
            },
            {
              "book": "xrp_usd",
              "minimum_price": "0.03",
              "maximum_price": "10",
              "minimum_amount": "0.0200000",
              "maximum_amount": "20000000",
              "minimum_value": "0.50000",
              "maximum_value": "10000000",
              "tick_size": "0.0001",
              "default_chart": "candle",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.00090",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00085",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.00080",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.00090"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00070",
                    "taker": "0.00080"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.00060",
                    "taker": "0.00070"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.00050",
                    "taker": "0.00060"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.00040",
                    "taker": "0.00050"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0.0000",
                    "taker": "0.00040"
                  }
                ]
              }
            },
            {
              "book": "eth_usd",
              "minimum_price": "100",
              "maximum_price": "50000",
              "minimum_amount": "0.0000040",
              "maximum_amount": "4000",
              "minimum_value": "0.50000",
              "maximum_value": "10000000",
              "tick_size": "0.1",
              "default_chart": "tradingview",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.00090",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00085",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.00080",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.00090"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00070",
                    "taker": "0.00080"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.00060",
                    "taker": "0.00070"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.00050",
                    "taker": "0.00060"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.00040",
                    "taker": "0.00050"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0.0000",
                    "taker": "0.00040"
                  }
                ]
              }
            },
            {
              "book": "dai_ars",
              "minimum_price": "10",
              "maximum_price": "4000",
              "minimum_amount": "0.0100000",
              "maximum_amount": "10000000",
              "minimum_value": "100",
              "maximum_value": "2000000000",
              "tick_size": "0.01",
              "default_chart": "tradingview",
              "fees": {
                "flat_rate": {
                  "maker": "0.003",
                  "taker": "0.006"
                },
                "structure": [
                  {
                    "volume": "650000",
                    "maker": "0.003",
                    "taker": "0.006"
                  },
                  {
                    "volume": "2600000",
                    "maker": "0.003",
                    "taker": "0.0055"
                  },
                  {
                    "volume": "6500000",
                    "maker": "0.0025",
                    "taker": "0.005"
                  },
                  {
                    "volume": "13000000",
                    "maker": "0.0025",
                    "taker": "0.0045"
                  },
                  {
                    "volume": "65000000",
                    "maker": "0.00175",
                    "taker": "0.004"
                  },
                  {
                    "volume": "130000000",
                    "maker": "0.00085",
                    "taker": "0.0035"
                  },
                  {
                    "volume": "325000000",
                    "maker": "0.0008",
                    "taker": "0.003"
                  },
                  {
                    "volume": "1300000000",
                    "maker": "0.0008",
                    "taker": "0.0025"
                  },
                  {
                    "volume": "2600000000",
                    "maker": "0.0008",
                    "taker": "0.002"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0.0008",
                    "taker": "0.0015"
                  }
                ]
              }
            },
            {
              "book": "btc_brl",
              "minimum_price": "10000",
              "maximum_price": "4000000",
              "minimum_amount": "0.0000003",
              "maximum_amount": "300",
              "minimum_value": "3.00000",
              "maximum_value": "60000000",
              "tick_size": "10",
              "default_chart": "tradingview",
              "fees": {
                "flat_rate": {
                  "maker": "0.002",
                  "taker": "0.004"
                },
                "structure": [
                  {
                    "volume": "541000",
                    "maker": "0.002",
                    "taker": "0.004"
                  },
                  {
                    "volume": "1352500",
                    "maker": "0.00200",
                    "taker": "0.00350"
                  },
                  {
                    "volume": "2705000",
                    "maker": "0.00175",
                    "taker": "0.00300"
                  },
                  {
                    "volume": "5410000",
                    "maker": "0.00150",
                    "taker": "0.00275"
                  },
                  {
                    "volume": "27050000",
                    "maker": "0.00125",
                    "taker": "0.00250"
                  },
                  {
                    "volume": "54100000",
                    "maker": "0.00100",
                    "taker": "0.00225"
                  },
                  {
                    "volume": "81150000",
                    "maker": "0.00095",
                    "taker": "0.00200"
                  },
                  {
                    "volume": "108200000",
                    "maker": "0.00090",
                    "taker": "0.00175"
                  },
                  {
                    "volume": "162300000",
                    "maker": "0.00085",
                    "taker": "0.00160"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0.00080",
                    "taker": "0.00150"
                  }
                ]
              }
            },
            {
              "book": "eth_ars",
              "minimum_price": "300",
              "maximum_price": "10000000",
              "minimum_amount": "0.0000040",
              "maximum_amount": "4000",
              "minimum_value": "100",
              "maximum_value": "2000000000",
              "tick_size": "10",
              "default_chart": "tradingview",
              "fees": {
                "flat_rate": {
                  "maker": "0.003",
                  "taker": "0.006"
                },
                "structure": [
                  {
                    "volume": "650000",
                    "maker": "0.003",
                    "taker": "0.006"
                  },
                  {
                    "volume": "2600000",
                    "maker": "0.00300",
                    "taker": "0.00550"
                  },
                  {
                    "volume": "6500000",
                    "maker": "0.00250",
                    "taker": "0.00500"
                  },
                  {
                    "volume": "13000000",
                    "maker": "0.00250",
                    "taker": "0.00450"
                  },
                  {
                    "volume": "65000000",
                    "maker": "0.00175",
                    "taker": "0.00400"
                  },
                  {
                    "volume": "130000000",
                    "maker": "0.00085",
                    "taker": "0.00350"
                  },
                  {
                    "volume": "325000000",
                    "maker": "0.00080",
                    "taker": "0.00300"
                  },
                  {
                    "volume": "1300000000",
                    "maker": "0.00080",
                    "taker": "0.00250"
                  },
                  {
                    "volume": "2600000000",
                    "maker": "0.00080",
                    "taker": "0.00200"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0.00080",
                    "taker": "0.00150"
                  }
                ]
              }
            },
            {
              "book": "eth_brl",
              "minimum_price": "700",
              "maximum_price": "300000",
              "minimum_amount": "0.0000040",
              "maximum_amount": "4000",
              "minimum_value": "3",
              "maximum_value": "60000000",
              "tick_size": "0.1",
              "default_chart": "tradingview",
              "fees": {
                "flat_rate": {
                  "maker": "0.002",
                  "taker": "0.004"
                },
                "structure": [
                  {
                    "volume": "541000",
                    "maker": "0.002",
                    "taker": "0.004"
                  },
                  {
                    "volume": "1352500",
                    "maker": "0.00200",
                    "taker": "0.00350"
                  },
                  {
                    "volume": "2705000",
                    "maker": "0.00175",
                    "taker": "0.00300"
                  },
                  {
                    "volume": "5410000",
                    "maker": "0.00150",
                    "taker": "0.00274"
                  },
                  {
                    "volume": "27050000",
                    "maker": "0.00125",
                    "taker": "0.00250"
                  },
                  {
                    "volume": "54100000",
                    "maker": "0.00100",
                    "taker": "0.00224"
                  },
                  {
                    "volume": "81150000",
                    "maker": "0.00095",
                    "taker": "0.00200"
                  },
                  {
                    "volume": "108200000",
                    "maker": "0.00090",
                    "taker": "0.00175"
                  },
                  {
                    "volume": "162300000",
                    "maker": "0.00084",
                    "taker": "0.00160"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0.00080",
                    "taker": "0.00150"
                  }
                ]
              }
            },
            {
              "book": "btc_usdt",
              "minimum_price": "2000",
              "maximum_price": "700000",
              "minimum_amount": "0.0000003",
              "maximum_amount": "300",
              "minimum_value": "0.50000",
              "maximum_value": "10000000",
              "tick_size": "1",
              "default_chart": "tradingview",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.0009",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.0008",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.0009"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.0008"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.0006",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.0005",
                    "taker": "0.0006"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.0004",
                    "taker": "0.0005"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0.0000",
                    "taker": "0.0004"
                  }
                ]
              }
            },
            {
              "book": "usd_mxn",
              "minimum_price": "1",
              "maximum_price": "400",
              "minimum_amount": "0.0100000",
              "maximum_amount": "10000000",
              "minimum_value": "10.00000",
              "maximum_value": "200000000",
              "tick_size": "0.001",
              "default_chart": "tradingview",
              "fees": {
                "flat_rate": {
                  "maker": "0.005",
                  "taker": "0.0065"
                },
                "structure": [
                  {
                    "volume": "1500000",
                    "maker": "0.005",
                    "taker": "0.0065"
                  },
                  {
                    "volume": "2000000",
                    "maker": "0.0049",
                    "taker": "0.00637"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.0048",
                    "taker": "0.00624"
                  },
                  {
                    "volume": "7000000",
                    "maker": "0.0044",
                    "taker": "0.00572"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.0042",
                    "taker": "0.00545"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.004",
                    "taker": "0.0052"
                  },
                  {
                    "volume": "35000000",
                    "maker": "0.0037",
                    "taker": "0.00481"
                  },
                  {
                    "volume": "50000000",
                    "maker": "0.003",
                    "taker": "0.00389"
                  },
                  {
                    "volume": "150000000",
                    "maker": "0.002",
                    "taker": "0.0026"
                  },
                  {
                    "volume": "250000000",
                    "maker": "0.001",
                    "taker": "0.0013"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0",
                    "taker": "0.0013"
                  }
                ]
              }
            },
            {
              "book": "usd_ars",
              "minimum_price": "10",
              "maximum_price": "5000",
              "minimum_amount": "0.0100000",
              "maximum_amount": "10000000",
              "minimum_value": "100.00000",
              "maximum_value": "2000000000",
              "tick_size": "0.01",
              "default_chart": "tradingview",
              "fees": {
                "flat_rate": {
                  "maker": "0.003",
                  "taker": "0.006"
                },
                "structure": [
                  {
                    "volume": "650000",
                    "maker": "0.003",
                    "taker": "0.006"
                  },
                  {
                    "volume": "2600000",
                    "maker": "0.003",
                    "taker": "0.00549"
                  },
                  {
                    "volume": "6500000",
                    "maker": "0.0025",
                    "taker": "0.005"
                  },
                  {
                    "volume": "13000000",
                    "maker": "0.0025",
                    "taker": "0.00449"
                  },
                  {
                    "volume": "65000000",
                    "maker": "0.00175",
                    "taker": "0.004"
                  },
                  {
                    "volume": "130000000",
                    "maker": "0.00084",
                    "taker": "0.0035"
                  },
                  {
                    "volume": "325000000",
                    "maker": "0.0008",
                    "taker": "0.003"
                  },
                  {
                    "volume": "1300000000",
                    "maker": "0.0008",
                    "taker": "0.0025"
                  },
                  {
                    "volume": "2600000000",
                    "maker": "0.0008",
                    "taker": "0.002"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0.0008",
                    "taker": "0.0015"
                  }
                ]
              }
            },
            {
              "book": "usd_brl",
              "minimum_price": "0.3",
              "maximum_price": "100",
              "minimum_amount": "0.0100000",
              "maximum_amount": "10000000",
              "minimum_value": "3.00000",
              "maximum_value": "60000000",
              "tick_size": "0.0001",
              "default_chart": "tradingview",
              "fees": {
                "flat_rate": {
                  "maker": "0.002",
                  "taker": "0.004"
                },
                "structure": [
                  {
                    "volume": "541000",
                    "maker": "0.002",
                    "taker": "0.004"
                  },
                  {
                    "volume": "1352500",
                    "maker": "0.002",
                    "taker": "0.0035"
                  },
                  {
                    "volume": "2705000",
                    "maker": "0.00175",
                    "taker": "0.003"
                  },
                  {
                    "volume": "5410000",
                    "maker": "0.0015",
                    "taker": "0.00274"
                  },
                  {
                    "volume": "27050000",
                    "maker": "0.00125",
                    "taker": "0.0025"
                  },
                  {
                    "volume": "54100000",
                    "maker": "0.001",
                    "taker": "0.00224"
                  },
                  {
                    "volume": "81150000",
                    "maker": "0.00095",
                    "taker": "0.002"
                  },
                  {
                    "volume": "108200000",
                    "maker": "0.0009",
                    "taker": "0.00175"
                  },
                  {
                    "volume": "162300000",
                    "maker": "0.00084",
                    "taker": "0.0016"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0.0008",
                    "taker": "0.0015"
                  }
                ]
              }
            },
            {
              "book": "mana_usd",
              "minimum_price": "0.1",
              "maximum_price": "40",
              "minimum_amount": "0.0050000",
              "maximum_amount": "5000000",
              "minimum_value": "0.50000",
              "maximum_value": "10000000",
              "tick_size": "0.00001",
              "default_chart": "tradingview",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.0009",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.0008",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.0009"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.0008"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.0006",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.0005",
                    "taker": "0.0006"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.0004",
                    "taker": "0.0005"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0",
                    "taker": "0.0004"
                  }
                ]
              }
            },
            {
              "book": "ltc_usd",
              "minimum_price": "5",
              "maximum_price": "2000",
              "minimum_amount": "0.0000900",
              "maximum_amount": "90000",
              "minimum_value": "0.50000",
              "maximum_value": "10000000",
              "tick_size": "0.001",
              "default_chart": "tradingview",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.0009",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.0008",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.0009"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.0008"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.0006",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.0005",
                    "taker": "0.0006"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.0004",
                    "taker": "0.0005"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0",
                    "taker": "0.0004"
                  }
                ]
              }
            },
            {
              "book": "comp_usd",
              "minimum_price": "6",
              "maximum_price": "3000",
              "minimum_amount": "0.0000800",
              "maximum_amount": "80000",
              "minimum_value": "0.50000",
              "maximum_value": "10000000",
              "tick_size": "0.01",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.0009",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.0008",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.0009"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.0008"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.0006",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.0005",
                    "taker": "0.0006"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.0004",
                    "taker": "0.0005"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0",
                    "taker": "0.0004"
                  }
                ]
              }
            },
            {
              "book": "link_usd",
              "minimum_price": "0.8",
              "maximum_price": "300",
              "minimum_amount": "0.0006000",
              "maximum_amount": "600000",
              "minimum_value": "0.50000",
              "maximum_value": "10000000",
              "tick_size": "0.01",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.0009",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.0008",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.0009"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.0008"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.0006",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.0005",
                    "taker": "0.0006"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.0004",
                    "taker": "0.0005"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0",
                    "taker": "0.0004"
                  }
                ]
              }
            },
            {
              "book": "uni_usd",
              "minimum_price": "0.5",
              "maximum_price": "200",
              "minimum_amount": "0.0009000",
              "maximum_amount": "900000",
              "minimum_value": "0.50000",
              "maximum_value": "10000000",
              "tick_size": "0.01",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.0009",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.0008",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.0009"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.0008"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.0006",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.0005",
                    "taker": "0.0006"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.0004",
                    "taker": "0.0005"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0",
                    "taker": "0.0004"
                  }
                ]
              }
            },
            {
              "book": "aave_usd",
              "minimum_price": "8",
              "maximum_price": "3000",
              "minimum_amount": "0.0000700",
              "maximum_amount": "70000",
              "minimum_value": "0.50000",
              "maximum_value": "10000000",
              "tick_size": "0.01",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.0009",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.0008",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.0009"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.0008"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.0006",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.0005",
                    "taker": "0.0006"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.0004",
                    "taker": "0.0005"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0",
                    "taker": "0.0004"
                  }
                ]
              }
            },
            {
              "book": "chz_usd",
              "minimum_price": "0.009",
              "maximum_price": "4",
              "minimum_amount": "0.0600000",
              "maximum_amount": "60000000",
              "minimum_value": "0.50000",
              "maximum_value": "10000000",
              "tick_size": "0.00001",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.0009",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.0008",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.0009"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.0008"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.0006",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.0005",
                    "taker": "0.0006"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.0004",
                    "taker": "0.0005"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0",
                    "taker": "0.0004"
                  }
                ]
              }
            },
            {
              "book": "btc_cop",
              "minimum_price": "8000000",
              "maximum_price": "3000000000",
              "minimum_amount": "0.0000002",
              "maximum_amount": "200",
              "minimum_value": "2000",
              "maximum_value": "40000000000",
              "tick_size": "10000",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.0035",
                  "taker": "0.0045"
                },
                "structure": [
                  {
                    "volume": "15000000",
                    "maker": "0.0035",
                    "taker": "0.0045"
                  },
                  {
                    "volume": "50000000",
                    "maker": "0.0035",
                    "taker": "0.004"
                  },
                  {
                    "volume": "150000000",
                    "maker": "0.0031",
                    "taker": "0.0034"
                  },
                  {
                    "volume": "300000000",
                    "maker": "0.0026",
                    "taker": "0.0031"
                  },
                  {
                    "volume": "1500000000",
                    "maker": "0.0022",
                    "taker": "0.0028"
                  },
                  {
                    "volume": "3000000000",
                    "maker": "0.0018",
                    "taker": "0.0025"
                  },
                  {
                    "volume": "7500000000",
                    "maker": "0.0017",
                    "taker": "0.0023"
                  },
                  {
                    "volume": "30000000000",
                    "maker": "0.0016",
                    "taker": "0.002"
                  },
                  {
                    "volume": "60000000000",
                    "maker": "0.0015",
                    "taker": "0.0018"
                  },
                  {
                    "volume": "99999999999999",
                    "maker": "0.0014",
                    "taker": "0.0017"
                  }
                ]
              }
            },
            {
              "book": "axs_usd",
              "minimum_price": "3",
              "maximum_price": "1000",
              "minimum_amount": "0.0002000",
              "maximum_amount": "200000",
              "minimum_value": "0.50000",
              "maximum_value": "10000000",
              "tick_size": "0.01",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.0009",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.0008",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.0009"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.0008"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.0006",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.0005",
                    "taker": "0.0006"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.0004",
                    "taker": "0.0005"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0",
                    "taker": "0.0004"
                  }
                ]
              }
            },
            {
              "book": "dydx_usd",
              "minimum_price": "0.3",
              "maximum_price": "100",
              "minimum_amount": "0.0020000",
              "maximum_amount": "2000000",
              "minimum_value": "0.50000",
              "maximum_value": "10000000",
              "tick_size": "0.01",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.0009",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.0008",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.0009"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.0008"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.0006",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.0005",
                    "taker": "0.0006"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.0004",
                    "taker": "0.0005"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0",
                    "taker": "0.0004"
                  }
                ]
              }
            },
            {
              "book": "yfi_usd",
              "minimum_price": "1000",
              "maximum_price": "500000",
              "minimum_amount": "0.0000004",
              "maximum_amount": "400",
              "minimum_value": "0.50000",
              "maximum_value": "10000000",
              "tick_size": "0.1",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.0009",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.0008",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.0009"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.0008"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.0006",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.0005",
                    "taker": "0.0006"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.0004",
                    "taker": "0.0005"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0",
                    "taker": "0.0004"
                  }
                ]
              }
            },
            {
              "book": "sand_usd",
              "minimum_price": "0.2",
              "maximum_price": "60",
              "minimum_amount": "0.0030000",
              "maximum_amount": "3000000",
              "minimum_value": "0.50000",
              "maximum_value": "10000000",
              "tick_size": "0.01",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.0009",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.0008",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.0009"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.0008"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.0006",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.0005",
                    "taker": "0.0006"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.0004",
                    "taker": "0.0005"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0",
                    "taker": "0.0004"
                  }
                ]
              }
            },
            {
              "book": "shib_usd",
              "minimum_price": "0.000001",
              "maximum_price": "0.0004",
              "minimum_amount": "500.0000000",
              "maximum_amount": "500000000000",
              "minimum_value": "0.50000",
              "maximum_value": "10000000",
              "tick_size": "0.00000001",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.0009",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.0008",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.0009"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.0008"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.0006",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.0005",
                    "taker": "0.0006"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.0004",
                    "taker": "0.0005"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0",
                    "taker": "0.0004"
                  }
                ]
              }
            },
            {
              "book": "snx_usd",
              "minimum_price": "0.2",
              "maximum_price": "90",
              "minimum_amount": "0.0020000",
              "maximum_amount": "2000000",
              "minimum_value": "0.50000",
              "maximum_value": "10000000",
              "tick_size": "0.01",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.0009",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.0008",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.0009"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.0008"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.0006",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.0005",
                    "taker": "0.0006"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.0004",
                    "taker": "0.0005"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0",
                    "taker": "0.0004"
                  }
                ]
              }
            },
            {
              "book": "matic_usd",
              "minimum_price": "0.08",
              "maximum_price": "30",
              "minimum_amount": "0.0060000",
              "maximum_amount": "6000000",
              "minimum_value": "0.50000",
              "maximum_value": "10000000",
              "tick_size": "0.01",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.0009",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.0008",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.0009"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.0008"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.0006",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.0005",
                    "taker": "0.0006"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.0004",
                    "taker": "0.0005"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0",
                    "taker": "0.0004"
                  }
                ]
              }
            },
            {
              "book": "mkr_usd",
              "minimum_price": "1",
              "maximum_price": "38000",
              "minimum_amount": "0.0003",
              "maximum_amount": "5500",
              "minimum_value": "0.50",
              "maximum_value": "10000000",
              "tick_size": "0.01",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.0009",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.0008",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.0009"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.0008"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.0006",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.0005",
                    "taker": "0.0006"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.0004",
                    "taker": "0.0005"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0",
                    "taker": "0.0004"
                  }
                ]
              }
            },
            {
              "book": "enj_usd",
              "minimum_price": "0.1",
              "maximum_price": "40",
              "minimum_amount": "0.01",
              "maximum_amount": "10000000",
              "minimum_value": "0.50",
              "maximum_value": "10000000",
              "tick_size": "0.01",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.0009",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.0008",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.0009"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.0008"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.0006",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.0005",
                    "taker": "0.0006"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.0004",
                    "taker": "0.0005"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0",
                    "taker": "0.0004"
                  }
                ]
              }
            },
            {
              "book": "ftm_usd",
              "minimum_price": "0.1",
              "maximum_price": "40",
              "minimum_amount": "0.005",
              "maximum_amount": "5000000",
              "minimum_value": "0.50",
              "maximum_value": "10000000",
              "tick_size": "0.0001",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.0009",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.0008",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.0009"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.0008"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.0006",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.0005",
                    "taker": "0.0006"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.0004",
                    "taker": "0.0005"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0",
                    "taker": "0.0004"
                  }
                ]
              }
            },
            {
              "book": "crv_usd",
              "minimum_price": "0.2",
              "maximum_price": "70",
              "minimum_amount": "0.003",
              "maximum_amount": "3000000",
              "minimum_value": "0.50",
              "maximum_value": "10000000",
              "tick_size": "0.0001",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.0009",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.0008",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.0009"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.0008"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.0006",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.0005",
                    "taker": "0.0006"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.0004",
                    "taker": "0.0005"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0",
                    "taker": "0.0004"
                  }
                ]
              }
            },
            {
              "book": "gala_usd",
              "minimum_price": "0.02",
              "maximum_price": "7",
              "minimum_amount": "0.03",
              "maximum_amount": "30000000",
              "minimum_value": "0.50",
              "maximum_value": "10000000",
              "tick_size": "0.000001",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.0009",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.0008",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.0009"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.0008"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.0006",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.0005",
                    "taker": "0.0006"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.0004",
                    "taker": "0.0005"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0",
                    "taker": "0.0004"
                  }
                ]
              }
            },
            {
              "book": "ada_usd",
              "minimum_price": "0.05",
              "maximum_price": "20",
              "minimum_amount": "0.01",
              "maximum_amount": "10000000",
              "minimum_value": "0.50",
              "maximum_value": "10000000",
              "tick_size": "0.0001",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.0009",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.0008",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.0009"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.0008"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.0006",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.0005",
                    "taker": "0.0006"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.0004",
                    "taker": "0.0005"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0",
                    "taker": "0.0004"
                  }
                ]
              }
            },
            {
              "book": "lrc_usd",
              "minimum_price": "0.04",
              "maximum_price": "20",
              "minimum_amount": "0.010",
              "maximum_amount": "10000000",
              "minimum_value": "0.50",
              "maximum_value": "10000000",
              "tick_size": "0.00001",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.0009",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.0008",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.0009"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.0008"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.0006",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.0005",
                    "taker": "0.0006"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.0004",
                    "taker": "0.0005"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0",
                    "taker": "0.0004"
                  }
                ]
              }
            },
            {
              "book": "grt_usd",
              "minimum_price": "0.02",
              "maximum_price": "8",
              "minimum_amount": "0.03",
              "maximum_amount": "30000000",
              "minimum_value": "0.50",
              "maximum_value": "10000000",
              "tick_size": "0.00001",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.0009",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.0008",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.0009"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.0008"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.0006",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.0005",
                    "taker": "0.0006"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.0004",
                    "taker": "0.0005"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0",
                    "taker": "0.0004"
                  }
                ]
              }
            },
            {
              "book": "ape_usd",
              "minimum_price": "0.4",
              "maximum_price": "100",
              "minimum_amount": "0.001",
              "maximum_amount": "1000000",
              "minimum_value": "0.50",
              "maximum_value": "10000000",
              "tick_size": "0.0001",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.0009",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.0008",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.0009"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.0008"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.0006",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.0005",
                    "taker": "0.0006"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.0004",
                    "taker": "0.0005"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0",
                    "taker": "0.0004"
                  }
                ]
              }
            },
            {
              "book": "sushi_usd",
              "minimum_price": "0.20",
              "maximum_price": "70",
              "minimum_amount": "0.003",
              "maximum_amount": "3000000",
              "minimum_value": "0.50",
              "maximum_value": "10000000",
              "tick_size": "0.0001",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.0009",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.0008",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.0009"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.0008"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.0006",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.0005",
                    "taker": "0.0006"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.0004",
                    "taker": "0.0005"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0",
                    "taker": "0.0004"
                  }
                ]
              }
            },
            {
              "book": "omg_usd",
              "minimum_price": "0.3",
              "maximum_price": "100",
              "minimum_amount": "0.002",
              "maximum_amount": "2000000",
              "minimum_value": "0.50",
              "maximum_value": "10000000",
              "tick_size": "0.0001",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.0009",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.0008",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.0009"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.0008"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.0006",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.0005",
                    "taker": "0.0006"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.0004",
                    "taker": "0.0005"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0",
                    "taker": "0.0004"
                  }
                ]
              }
            },
            {
              "book": "sol_usd",
              "minimum_price": "4",
              "maximum_price": "2000",
              "minimum_amount": "0.0001",
              "maximum_amount": "100000",
              "minimum_value": "0.50",
              "maximum_value": "10000000",
              "tick_size": "0.001",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.0009",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.0008",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.0009"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.0008"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.0006",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.0005",
                    "taker": "0.0006"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.0004",
                    "taker": "0.0005"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0",
                    "taker": "0.0004"
                  }
                ]
              }
            },
            {
              "book": "dot_usd",
              "minimum_price": "0.8",
              "maximum_price": "300",
              "minimum_amount": "0.0006",
              "maximum_amount": "600000",
              "minimum_value": "0.50",
              "maximum_value": "10000000",
              "tick_size": "0.001",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.0009",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.0008",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.0009"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.0008"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.0006",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.0005",
                    "taker": "0.0006"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.0004",
                    "taker": "0.0005"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0",
                    "taker": "0.0004"
                  }
                ]
              }
            },
            {
              "book": "qnt_usd",
              "minimum_price": "6",
              "maximum_price": "2000",
              "minimum_amount": "0.00009",
              "maximum_amount": "90000",
              "minimum_value": "0.50",
              "maximum_value": "10000000",
              "tick_size": "0.01",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.0009",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.0008",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.0009"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.0008"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.0006",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.0005",
                    "taker": "0.0006"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.0004",
                    "taker": "0.0005"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0",
                    "taker": "0.0004"
                  }
                ]
              }
            },
            {
              "book": "doge_usd",
              "minimum_price": "0.006",
              "maximum_price": "3",
              "minimum_amount": "0.08",
              "maximum_amount": "80000000",
              "minimum_value": "0.50",
              "maximum_value": "10000000",
              "tick_size": "0.00001",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.0009",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.0008",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.0009"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.0008"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.0006",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.0005",
                    "taker": "0.0006"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.0004",
                    "taker": "0.0005"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0",
                    "taker": "0.0004"
                  }
                ]
              }
            },
            {
              "book": "eth_cop",
              "minimum_price": "600000",
              "maximum_price": "200000000",
              "minimum_amount": "0.000004",
              "maximum_amount": "4000",
              "minimum_value": "2000",
              "maximum_value": "40000000000",
              "tick_size": "1000",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.0035",
                  "taker": "0.0045"
                },
                "structure": [
                  {
                    "volume": "15000000",
                    "maker": "0.0035",
                    "taker": "0.0045"
                  },
                  {
                    "volume": "50000000",
                    "maker": "0.0035",
                    "taker": "0.004"
                  },
                  {
                    "volume": "150000000",
                    "maker": "0.0031",
                    "taker": "0.0034"
                  },
                  {
                    "volume": "300000000",
                    "maker": "0.0026",
                    "taker": "0.0031"
                  },
                  {
                    "volume": "1500000000",
                    "maker": "0.0022",
                    "taker": "0.0028"
                  },
                  {
                    "volume": "3000000000",
                    "maker": "0.0018",
                    "taker": "0.0025"
                  },
                  {
                    "volume": "7500000000",
                    "maker": "0.0017",
                    "taker": "0.0023"
                  },
                  {
                    "volume": "30000000000",
                    "maker": "0.0016",
                    "taker": "0.002"
                  },
                  {
                    "volume": "60000000000",
                    "maker": "0.0015",
                    "taker": "0.0018"
                  },
                  {
                    "volume": "99999999999999",
                    "maker": "0.0014",
                    "taker": "0.0017"
                  }
                ]
              }
            },
            {
              "book": "xrp_cop",
              "minimum_price": "100",
              "maximum_price": "60000",
              "minimum_amount": "0.02",
              "maximum_amount": "20000000",
              "minimum_value": "2000",
              "maximum_value": "40000000000",
              "tick_size": "0.1",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.0035",
                  "taker": "0.0045"
                },
                "structure": [
                  {
                    "volume": "15000000",
                    "maker": "0.0035",
                    "taker": "0.0045"
                  },
                  {
                    "volume": "50000000",
                    "maker": "0.0035",
                    "taker": "0.004"
                  },
                  {
                    "volume": "150000000",
                    "maker": "0.0031",
                    "taker": "0.0034"
                  },
                  {
                    "volume": "300000000",
                    "maker": "0.0026",
                    "taker": "0.0031"
                  },
                  {
                    "volume": "1500000000",
                    "maker": "0.0022",
                    "taker": "0.0028"
                  },
                  {
                    "volume": "3000000000",
                    "maker": "0.0018",
                    "taker": "0.0025"
                  },
                  {
                    "volume": "7500000000",
                    "maker": "0.0017",
                    "taker": "0.0023"
                  },
                  {
                    "volume": "30000000000",
                    "maker": "0.0016",
                    "taker": "0.002"
                  },
                  {
                    "volume": "60000000000",
                    "maker": "0.0015",
                    "taker": "0.0018"
                  },
                  {
                    "volume": "99999999999999",
                    "maker": "0.0014",
                    "taker": "0.0017"
                  }
                ]
              }
            },
            {
              "book": "usd_cop",
              "minimum_price": "200",
              "maximum_price": "80000",
              "minimum_amount": "0.01",
              "maximum_amount": "10000000",
              "minimum_value": "2000",
              "maximum_value": "40000000000",
              "tick_size": "0.1",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.0035",
                  "taker": "0.0045"
                },
                "structure": [
                  {
                    "volume": "15000000",
                    "maker": "0.0035",
                    "taker": "0.0045"
                  },
                  {
                    "volume": "50000000",
                    "maker": "0.0035",
                    "taker": "0.004"
                  },
                  {
                    "volume": "150000000",
                    "maker": "0.0031",
                    "taker": "0.0034"
                  },
                  {
                    "volume": "300000000",
                    "maker": "0.0026",
                    "taker": "0.0031"
                  },
                  {
                    "volume": "1500000000",
                    "maker": "0.0022",
                    "taker": "0.0028"
                  },
                  {
                    "volume": "3000000000",
                    "maker": "0.0018",
                    "taker": "0.0025"
                  },
                  {
                    "volume": "7500000000",
                    "maker": "0.0017",
                    "taker": "0.0023"
                  },
                  {
                    "volume": "30000000000",
                    "maker": "0.0016",
                    "taker": "0.002"
                  },
                  {
                    "volume": "60000000000",
                    "maker": "0.0015",
                    "taker": "0.0018"
                  },
                  {
                    "volume": "99999999999999",
                    "maker": "0.0014",
                    "taker": "0.0017"
                  }
                ]
              }
            },
            {
              "book": "bal_usd",
              "minimum_price": "0.4",
              "maximum_price": "200",
              "minimum_amount": "0.001",
              "maximum_amount": "1000000",
              "minimum_value": "0.50",
              "maximum_value": "10000000",
              "tick_size": "0.0001",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.0009",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.0008",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.0009"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.0008"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.0006",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.0005",
                    "taker": "0.0006"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.0004",
                    "taker": "0.0005"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0",
                    "taker": "0.0004"
                  }
                ]
              }
            },
            {
              "book": "trx_usd",
              "minimum_price": "0.004",
              "maximum_price": "2",
              "minimum_amount": "0.1",
              "maximum_amount": "100000000",
              "minimum_value": "0.50",
              "maximum_value": "10000000",
              "tick_size": "0.0001",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.0009",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.0008",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.0009"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.0008"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.0006",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.0005",
                    "taker": "0.0006"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.0004",
                    "taker": "0.0005"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0",
                    "taker": "0.0004"
                  }
                ]
              }
            },
            {
              "book": "algo_usd",
              "minimum_price": "0.02",
              "maximum_price": "7",
              "minimum_amount": "0.03",
              "maximum_amount": "30000000",
              "minimum_value": "0.50",
              "maximum_value": "10000000",
              "tick_size": "0.0001",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.0009",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.0008",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.0009"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.0008"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.0006",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.0005",
                    "taker": "0.0006"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.0004",
                    "taker": "0.0005"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0",
                    "taker": "0.0004"
                  }
                ]
              }
            },
            {
              "book": "ldo_usd",
              "minimum_price": "0.1",
              "maximum_price": "50.0",
              "minimum_amount": "0.004",
              "maximum_amount": "4000000.0",
              "minimum_value": "0.5",
              "maximum_value": "10000000",
              "tick_size": "0.00010",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.00090",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.00080",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.00090"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.00080"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.00060",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.00050",
                    "taker": "0.00060"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.00040",
                    "taker": "0.00050"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0.0",
                    "taker": "0.00040"
                  }
                ]
              }
            },
            {
              "book": "xlm_usd",
              "minimum_price": "0.006",
              "maximum_price": "2.0",
              "minimum_amount": "0.09",
              "maximum_amount": "90000000",
              "minimum_value": "0.5",
              "maximum_value": "10000000",
              "tick_size": "0.000010",
              "default_chart": "depth",
              "fees": {
                "flat_rate": {
                  "maker": "0.00095",
                  "taker": "0.00099"
                },
                "structure": [
                  {
                    "volume": "500000",
                    "maker": "0.00095",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1000000",
                    "maker": "0.00090",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "1500000",
                    "maker": "0.00084",
                    "taker": "0.00099"
                  },
                  {
                    "volume": "3000000",
                    "maker": "0.00080",
                    "taker": "0.00095"
                  },
                  {
                    "volume": "5000000",
                    "maker": "0.00075",
                    "taker": "0.00090"
                  },
                  {
                    "volume": "10000000",
                    "maker": "0.00069",
                    "taker": "0.00080"
                  },
                  {
                    "volume": "15000000",
                    "maker": "0.00060",
                    "taker": "0.00069"
                  },
                  {
                    "volume": "20000000",
                    "maker": "0.00050",
                    "taker": "0.00060"
                  },
                  {
                    "volume": "30000000",
                    "maker": "0.00040",
                    "taker": "0.00050"
                  },
                  {
                    "volume": "9999999999",
                    "maker": "0.0",
                    "taker": "0.00040"
                  }
                ]
              }
            }
          ]
        }
        """, nil)
    }
    
    
    enum Error: Swift.Error {
        case unexpectedResult
    }
    
    func test(_ jsonString: String, _ expectedResult: String?)  {
        guard let codableCode = jsonString.codableCode else {
            guard expectedResult == nil else {
                XCTFail()
                return
            }
            return
        }
        
        guard codableCode == expectedResult else {
            print("json string")
            jsonString.printEscaping()
            print("codable code")
            codableCode.printEscaping()
            print("expected result")
            expectedResult?.printEscaping()
            XCTFail()
            return
        }
    }
    
}
