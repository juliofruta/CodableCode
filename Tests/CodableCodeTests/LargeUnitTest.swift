//
//  LargeUnitTest.swift
//  
//
//  Created by Julio Cesar Guzman Villanueva on 10/1/23.
//

import XCTest
@testable import CodableCode

final class LargeUnitTest: XCTestCase {
    
    func testNames() {
        var names = ["nombre"]
        XCTAssert("nombre".name(namesAlreadyUsed: &names) == "nombre1")
        
        var names2 = ["nombre1"]
        XCTAssert("nombre".name(namesAlreadyUsed: &names2) == "nombre")
        
        var names3 = ["nombre", "nombre1"]
        XCTAssert("nombre".name(namesAlreadyUsed: &names3) == "nombre2")
        
        var names4 = ["nombre", "nombree"]
        XCTAssert("nombre".name(namesAlreadyUsed: &names4) == "nombre1")
    }
    
    func testLargeJSON() throws {
        try test(
            """
            {
              "piano": "excited",
              "pocket": "exact",
              "adjective": true,
              "pig": [
                "directly",
                {
                  "history": {
                    "catch": {
                      "primitive": 609996791,
                      "weather": -2108820442,
                      "glad": true,
                      "twenty": "interest",
                      "owner": 1104233074,
                      "there": "catch",
                      "toward": [
                        [
                          [
                            "telephone",
                            976885672,
                            -518507024.8322542,
                            1950746109.5019517,
                            "snake",
                            "perfectly",
                            [
                              [
                                {
                                  "house": true,
                                  "court": {
                                    "habit": [
                                      {
                                        "possibly": -927237183,
                                        "hurried": {
                                          "to": {
                                            "shelter": 784546424,
                                            "cotton": false,
                                            "ride": false,
                                            "value": 1429739876,
                                            "country": "physical",
                                            "nation": {
                                              "fighting": true,
                                              "writer": [
                                                -717311705,
                                                -97654412,
                                                [
                                                  [
                                                    false,
                                                    [
                                                      126356434.8621552,
                                                      {
                                                        "feel": 530844254.98744726,
                                                        "have": true,
                                                        "round": "probably",
                                                        "using": [
                                                          238249600,
                                                          [
                                                            false,
                                                            false,
                                                            [
                                                              [
                                                                "wood",
                                                                [
                                                                  "driver",
                                                                  {
                                                                    "speech": "somewhere",
                                                                    "loud": 374416441,
                                                                    "castle": "changing",
                                                                    "whom": {
                                                                      "steel": "ask",
                                                                      "are": [
                                                                        -1696431228.3928573,
                                                                        false,
                                                                        {
                                                                          "favorite": false,
                                                                          "stop": [
                                                                            "reader",
                                                                            {
                                                                              "when": "world",
                                                                              "like": false,
                                                                              "got": "signal",
                                                                              "mainly": [
                                                                                [
                                                                                  [
                                                                                    44895481.74887347,
                                                                                    {
                                                                                      "environment": {
                                                                                        "no": false,
                                                                                        "feel": [
                                                                                          {
                                                                                            "last": {
                                                                                              "volume": "here",
                                                                                              "easier": {
                                                                                                "present": {
                                                                                                  "taught": false,
                                                                                                  "tie": "pot",
                                                                                                  "cup": {
                                                                                                    "property": false,
                                                                                                    "older": {
                                                                                                      "wolf": [
                                                                                                        true,
                                                                                                        false,
                                                                                                        {
                                                                                                          "strip": "field",
                                                                                                          "our": "ranch",
                                                                                                          "its": {
                                                                                                            "whale": true,
                                                                                                            "late": "badly",
                                                                                                            "heat": {
                                                                                                              "visit": [
                                                                                                                "raw",
                                                                                                                {
                                                                                                                  "garage": "seldom",
                                                                                                                  "salmon": "some",
                                                                                                                  "law": 1153786862,
                                                                                                                  "flies": "musical",
                                                                                                                  "wing": "constantly",
                                                                                                                  "sure": -1479395448,
                                                                                                                  "bicycle": true,
                                                                                                                  "zero": false,
                                                                                                                  "stop": "get",
                                                                                                                  "stranger": "substance"
                                                                                                                },
                                                                                                                true,
                                                                                                                "green",
                                                                                                                true,
                                                                                                                true,
                                                                                                                true,
                                                                                                                "rod",
                                                                                                                true,
                                                                                                                false
                                                                                                              ],
                                                                                                              "wooden": "allow",
                                                                                                              "noise": true,
                                                                                                              "folks": "difference",
                                                                                                              "lead": "found",
                                                                                                              "yourself": "rather",
                                                                                                              "nobody": 1583259763,
                                                                                                              "which": -120732211,
                                                                                                              "walk": 1151273016.2567217,
                                                                                                              "score": "attempt"
                                                                                                            },
                                                                                                            "group": "reason",
                                                                                                            "mine": false,
                                                                                                            "discover": "fully",
                                                                                                            "get": -307857016.5225291,
                                                                                                            "moon": -1010343238,
                                                                                                            "treated": false,
                                                                                                            "month": true
                                                                                                          },
                                                                                                          "finish": 636962886.5705588,
                                                                                                          "cage": "blank",
                                                                                                          "salmon": true,
                                                                                                          "do": false,
                                                                                                          "while": 387709194,
                                                                                                          "box": "regular",
                                                                                                          "grass": 420490807
                                                                                                        },
                                                                                                        1785092594,
                                                                                                        "lady",
                                                                                                        true,
                                                                                                        true,
                                                                                                        false,
                                                                                                        1044790304.903584,
                                                                                                        false
                                                                                                      ],
                                                                                                      "line": -1686213547.4779775,
                                                                                                      "exclaimed": -1373569217.0317068,
                                                                                                      "wonderful": "scene",
                                                                                                      "whole": 1273173065,
                                                                                                      "lose": true,
                                                                                                      "cloud": 310112813.4941008,
                                                                                                      "include": true,
                                                                                                      "about": false,
                                                                                                      "camp": "larger"
                                                                                                    },
                                                                                                    "prepare": "difficulty",
                                                                                                    "group": false,
                                                                                                    "any": false,
                                                                                                    "substance": -185135145,
                                                                                                    "pretty": 1547826226,
                                                                                                    "fox": false,
                                                                                                    "crack": true,
                                                                                                    "outer": "another"
                                                                                                  },
                                                                                                  "current": 209500481,
                                                                                                  "fastened": "stage",
                                                                                                  "telephone": "fine",
                                                                                                  "event": "spite",
                                                                                                  "dust": 1840101725.4635837,
                                                                                                  "cowboy": false,
                                                                                                  "afternoon": 24915117
                                                                                                },
                                                                                                "bite": "fifty",
                                                                                                "review": "swung",
                                                                                                "riding": 1432951515.0767584,
                                                                                                "recognize": "result",
                                                                                                "pictured": "shirt",
                                                                                                "charge": 295092096.2219429,
                                                                                                "she": true,
                                                                                                "ran": 1994541985,
                                                                                                "field": 29098645
                                                                                              },
                                                                                              "combination": -1892810204.269999,
                                                                                              "language": 456916746,
                                                                                              "brass": false,
                                                                                              "driven": "of",
                                                                                              "done": "captured",
                                                                                              "to": 1338501331,
                                                                                              "wheat": 1910593171.8545878,
                                                                                              "whistle": -1497197523.3606372
                                                                                            },
                                                                                            "office": true,
                                                                                            "spread": -1873185553.8165734,
                                                                                            "applied": false,
                                                                                            "art": true,
                                                                                            "born": 1017789566.1606178,
                                                                                            "couple": false,
                                                                                            "choice": "fence",
                                                                                            "mine": -922174688.1935959,
                                                                                            "space": "immediately"
                                                                                          },
                                                                                          false,
                                                                                          -966061826,
                                                                                          -886739724,
                                                                                          2042100411,
                                                                                          1633605955,
                                                                                          -189376164.04852915,
                                                                                          "desk",
                                                                                          "who",
                                                                                          1156669372
                                                                                        ],
                                                                                        "clothing": "table",
                                                                                        "wide": true,
                                                                                        "rhythm": false,
                                                                                        "grabbed": -546265215,
                                                                                        "education": true,
                                                                                        "simply": "west",
                                                                                        "girl": "young",
                                                                                        "thing": -1904143219.4454045
                                                                                      },
                                                                                      "love": -1217703745.0854685,
                                                                                      "porch": "bicycle",
                                                                                      "most": 981809666,
                                                                                      "government": true,
                                                                                      "swing": "grabbed",
                                                                                      "on": "race",
                                                                                      "from": false,
                                                                                      "whatever": 937267324,
                                                                                      "coming": true
                                                                                    },
                                                                                    false,
                                                                                    "rapidly",
                                                                                    true,
                                                                                    "gas",
                                                                                    -560192124,
                                                                                    true,
                                                                                    "hold",
                                                                                    "original"
                                                                                  ],
                                                                                  false,
                                                                                  "thread",
                                                                                  true,
                                                                                  "not",
                                                                                  true,
                                                                                  1032741374,
                                                                                  "higher",
                                                                                  "remarkable",
                                                                                  -1577234758
                                                                                ],
                                                                                true,
                                                                                "drove",
                                                                                -703215098.9565933,
                                                                                2107701188,
                                                                                false,
                                                                                "western",
                                                                                true,
                                                                                "prepare",
                                                                                true
                                                                              ],
                                                                              "mostly": 1594138011,
                                                                              "hunt": true,
                                                                              "darkness": "large",
                                                                              "title": true,
                                                                              "danger": "education",
                                                                              "record": false
                                                                            },
                                                                            false,
                                                                            1630106165.337244,
                                                                            false,
                                                                            -232212992,
                                                                            "sense",
                                                                            -1078999804,
                                                                            -2117706885.3501933,
                                                                            "hurry"
                                                                          ],
                                                                          "surprise": false,
                                                                          "happen": "pool",
                                                                          "listen": 119614555.01917791,
                                                                          "season": "characteristic",
                                                                          "especially": false,
                                                                          "direct": 1589518580,
                                                                          "population": true,
                                                                          "disease": true
                                                                        },
                                                                        false,
                                                                        -1369960219.5807028,
                                                                        554769342.8940251,
                                                                        "topic",
                                                                        false,
                                                                        true,
                                                                        "build"
                                                                      ],
                                                                      "dinner": false,
                                                                      "drop": false,
                                                                      "soap": "contrast",
                                                                      "search": false,
                                                                      "closely": -695610640,
                                                                      "chart": 1217796830,
                                                                      "water": "follow",
                                                                      "write": 1021999572.4583263
                                                                    },
                                                                    "tall": true,
                                                                    "slave": false,
                                                                    "loose": true,
                                                                    "west": "answer",
                                                                    "tower": "vessels",
                                                                    "doctor": "review"
                                                                  },
                                                                  -1636035130.4957426,
                                                                  true,
                                                                  false,
                                                                  -1678313558,
                                                                  false,
                                                                  744667677,
                                                                  false,
                                                                  "contrast"
                                                                ],
                                                                false,
                                                                false,
                                                                "country",
                                                                "appropriate",
                                                                true,
                                                                -1289589987.9317503,
                                                                "are",
                                                                210928790.03699422
                                                              ],
                                                              -559109445.9284089,
                                                              "chief",
                                                              -341386338.0160167,
                                                              false,
                                                              "knife",
                                                              1534187476.3722367,
                                                              1753618895,
                                                              true,
                                                              1059068362.5735741
                                                            ],
                                                            453474938,
                                                            -1997830233,
                                                            602702718,
                                                            true,
                                                            "warn",
                                                            false,
                                                            "parent"
                                                          ],
                                                          1981356334,
                                                          "cannot",
                                                          "now",
                                                          false,
                                                          "rain",
                                                          1008437866,
                                                          true,
                                                          "single"
                                                        ],
                                                        "ants": "see",
                                                        "organized": -488110477,
                                                        "title": "shelter",
                                                        "beneath": 1595724490,
                                                        "rise": "success",
                                                        "wolf": "cage"
                                                      },
                                                      true,
                                                      "process",
                                                      "nearby",
                                                      false,
                                                      "earn",
                                                      1672484063.652508,
                                                      "taken",
                                                      "expression"
                                                    ],
                                                    "garden",
                                                    -1458651057.504768,
                                                    2092901302,
                                                    -54014095,
                                                    false,
                                                    -1217948997,
                                                    -1485086133,
                                                    "send"
                                                  ],
                                                  -803186374.1726873,
                                                  true,
                                                  false,
                                                  -1170889334,
                                                  "run",
                                                  true,
                                                  "said",
                                                  "example",
                                                  -803999270.142338
                                                ],
                                                "blind",
                                                "serious",
                                                true,
                                                "baseball",
                                                false,
                                                true,
                                                598909954.9252894
                                              ],
                                              "bad": "hold",
                                              "wrong": "cabin",
                                              "swing": -1171293929.5763533,
                                              "please": "jungle",
                                              "aside": 1746402248.1871743,
                                              "enjoy": -2026601525,
                                              "say": 1315738812.7453787,
                                              "purpose": 1299060094.7373908
                                            },
                                            "close": 240018769.56709862,
                                            "uncle": 1224924552.085723,
                                            "hidden": "when",
                                            "beyond": false
                                          },
                                          "route": "experiment",
                                          "tribe": "child",
                                          "gravity": true,
                                          "box": "save",
                                          "wrapped": "person",
                                          "familiar": "passage",
                                          "relationship": -2003621420.3448741,
                                          "mean": "cloud",
                                          "doctor": "window"
                                        },
                                        "burst": "shinning",
                                        "held": true,
                                        "shop": "parts",
                                        "spend": -857971783,
                                        "thing": 1946110821,
                                        "handsome": "diameter",
                                        "turn": false,
                                        "familiar": -368735126
                                      },
                                      "star",
                                      "reader",
                                      "like",
                                      "health",
                                      "quite",
                                      "shinning",
                                      -432138567.1268649,
                                      "bear",
                                      "excellent"
                                    ],
                                    "changing": "unhappy",
                                    "correctly": false,
                                    "divide": true,
                                    "trap": true,
                                    "paint": true,
                                    "many": "divide",
                                    "street": "individual",
                                    "depth": "adventure",
                                    "to": true
                                  },
                                  "division": "plastic",
                                  "whispered": true,
                                  "driving": "sink",
                                  "sick": true,
                                  "love": false,
                                  "advice": false,
                                  "safe": true,
                                  "location": 1083128775
                                },
                                "friend",
                                "easier",
                                "through",
                                "across",
                                "shake",
                                "put",
                                "apple",
                                -48181988,
                                "include"
                              ],
                              "bare",
                              true,
                              false,
                              -507964233,
                              false,
                              "terrible",
                              true,
                              -1716028826,
                              "worse"
                            ],
                            "becoming",
                            -373087529.1566279,
                            "powerful"
                          ],
                          808694839.369385,
                          true,
                          true,
                          true,
                          "city",
                          true,
                          "area",
                          true,
                          "manufacturing"
                        ],
                        "native",
                        "money",
                        true,
                        false,
                        false,
                        "fellow",
                        true,
                        "replied",
                        true
                      ],
                      "government": false,
                      "stop": true,
                      "fire": true
                    },
                    "trade": false,
                    "society": true,
                    "curious": -1844519528,
                    "possible": true,
                    "held": 309786789.10744977,
                    "zero": "uncle",
                    "having": true,
                    "therefore": "front",
                    "history": false
                  },
                  "white": "dropped",
                  "caught": false,
                  "outline": "growth",
                  "brother": 787753631,
                  "sent": 592456384.1851053,
                  "eight": 1439590655,
                  "cry": false,
                  "finest": -716287578.7124658,
                  "perfect": 1450177686
                },
                "research",
                249656000.55208635,
                "mouse",
                true,
                "tonight",
                true,
                "newspaper",
                false
              ],
              "full": -979463745,
              "electric": true,
              "battle": true,
              "shoulder": "tongue",
              "name": false,
              "stepped": 1106155562.3977332
            }
            """,
            .success("")
        )
    }
}
