//
//  UnicodeLiterals.swift
//
//  Created by Joe Cardenas on 12/6/21.
//

// swiftlint:disable line_length

import Foundation

/**
 Collections of useful unicode characters.
 
 Thanks to combatwombat and his [Lunicode.js project]( https://github.com/combatwombat/Lunicode.js ). These lists were largely formed from the code in his project.
 */
struct UnicodeLiterals {
    
    // MARK: Diacritics
    
    /** Diacritics to go on the top of a character. */
    static let diacriticsTop: [String] = ["̀", "́", "̂", "̃", "̄", "̅", "̆", "̇", "̈", "̉", "̊", "̋", "̌", "̍", "̎", "̏", "̐", "̑", "̒", "̓", "̔", "̕", "̚", "̛", "̽", "̾", "̿", "̀", "́", "͂", "̓", "̈́", "̈́", "͆", "͊", "͋", "͌", "͐", "͑", "͒", "͗", "͘", "͛", "͝", "͝", "͠", "͡"]
    
    /** Chooses and returns a random diacritic from the diacriticsTop list. */
    static func randomTopDiacritic() -> String {
        return diacriticsTop[
            Int(arc4random_uniform(
                UInt32(diacriticsTop.count)
            ))
        ]
    }
    
    /** Diacritics to go in the middle of a character. */
    static let diacriticsMiddle: [String] = ["̴", "̵", "̶", "̷", "̸"]
    
    /** Chooses and returns a random diacritic from the diacriticsMiddle list. */
    static func randomMiddleDiacritic() -> String {
        return diacriticsMiddle[
            Int(arc4random_uniform(
                UInt32(diacriticsMiddle.count)
            ))
        ]
    }
    
    /** Diacritics to go on the bottom of a character. */
    static let diacriticsBottom: [String] = ["̖", "̗", "̘", "̙", "̜", "̝", "̞", "̟", "̠", "̡", "̢", "̣", "̤", "̥", "̦", "̧", "̨", "̩", "̪", "̫", "̬", "̭", "̮", "̯", "̰", "̱", "̲", "̳", "̹", "̺", "̻", "̼", "ͅ", "͇", "͈", "͉", "͍", "͎", "͓", "͔", "͕", "͖", "͙", "͚", "͜", "͟"]

    /** Chooses and returns a random diacritic from the diacriticsBottom list. */
    static func randomBottomDiacritic() -> String {
        return diacriticsBottom[
            Int(arc4random_uniform(
                UInt32(diacriticsBottom.count)
            ))
        ]
    }
    
    // MARK: Da-Vinci Characters
    // da vinky
    
    /** A map of standard characters to their reversed counterparts. */
    static let daVinciCharacters: [String: String] = [
        "a": "\u{0250}",
        "b": "q",
        "c": "\u{0254}",
        "d": "p",
        "e": "\u{01DD}",
        "f": "\u{025F}",
        "g": "\u{0253}",
        "h": "\u{0265}",
        "i": "\u{0131}",
        "j": "\u{027E}",
        "k": "\u{029E}",
        "l": "\u{006C}",
        "m": "\u{026F}",
        "n": "u",
        "p": "d",
        "r": "\u{0279}",
        "t": "\u{0287}",
        "v": "\u{028C}",
        "w": "\u{028D}",
        "y": "\u{028E}",
        "A": "\u{2200}",
        "B": "ᙠ",
        "C": "\u{0186}",
        "D": "ᗡ",
        "E": "\u{018e}",
        "F": "\u{2132}",
        "G": "\u{2141}",
        "J": "\u{017f}",
        "K": "\u{22CA}",
        "L": "\u{02e5}",
        "M": "W",
        "P": "\u{0500}",
        "Q": "\u{038C}",
        "R": "\u{1D1A}",
        "T": "\u{22a5}",
        "U": "\u{2229}",
        "V": "\u{039B}",
        "W": "M",
        "Y": "\u{2144}",
        "1": "\u{21c2}",
        "2": "\u{1105}",
        "3": "\u{0190}",
        "4": "\u{3123}",
        "5": "\u{03DB}",
        "6": "9",
        "7": "\u{3125}",
        "9": "6",
        "&": "\u{214b}",
        ".": "\u{02D9}",
        "\"": "\u{201e}",
        ";": "\u{061b}",
        "[": "]",
        "(": ")",
        "{": "}",
        "?": "\u{00BF}",
        "!": "\u{00A1}",
        "'": ",",
        "’": ",",
        ",": "'",
        "<": ">",
        "\u{203E}": "_",
        "\u{00AF}": "_",
        "\u{203F}": "\u{2040}",
        "\u{2045}": "\u{2046}",
        "\u{2234}": "\u{2235}",
        "\r": "\n",
        "ß": "ᙠ",

        "\u{0308}": "\u{0324}",
        "ä": "ɐ"+"\u{0324}",
        "ö": "o"+"\u{0324}",
        "ü": "n"+"\u{0324}",
        "Ä": "\u{2200}"+"\u{0324}",
        "Ö": "O"+"\u{0324}",
        "Ü": "\u{2229}"+"\u{0324}",

        "´": " \u{0317}",
        "é": "\u{01DD}" + "\u{0317}",
        "á": "\u{0250}" + "\u{0317}",
        "ó": "o" + "\u{0317}",
        "ú": "n" + "\u{0317}",
        "É": "\u{018e}" + "\u{0317}",
        "Á": "\u{2200}" + "\u{0317}",
        "Ó": "O" + "\u{0317}",
        "Ú": "\u{2229}" + "\u{0317}",

        "`": " \u{0316}",
        "è": "\u{01DD}" + "\u{0316}",
        "à": "\u{0250}" + "\u{0316}",
        "ò": "o" + "\u{0316}",
        "ù": "n" + "\u{0316}",
        "È": "\u{018e}" + "\u{0316}",
        "À": "\u{2200}" + "\u{0316}",
        "Ò": "O" + "\u{0316}",
        "Ù": "\u{2229}" + "\u{0316}",

        "^": " \u{032E}",
        "ê": "\u{01DD}" + "\u{032e}",
        "â": "\u{0250}" + "\u{032e}",
        "ô": "o" + "\u{032e}",
        "û": "n" + "\u{032e}",
        "Ê": "\u{018e}" + "\u{032e}",
        "Â": "\u{2200}" + "\u{032e}",
        "Ô": "O" + "\u{032e}",
        "Û": "\u{2229}" + "\u{032e}"
    ]
    
}
