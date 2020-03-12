//
//  ContentsquareTracker.swift
//  TealiumContentsquare
//
//  Created by Jonathan Wong on 3/6/20.
//  Copyright © 2020 Jonathan Wong. All rights reserved.
//

import Foundation
import ContentsquareModule

public class ContentsquareTracker: ContentsquareTrackable {
    
    public init() {}
    
    public func sendScreenView(screenName: String) {
        Contentsquare.send(screenViewWithName: screenName)
    }
    
    public func sendTransaction(price: Double, currency: Int, transactionId: String?) {
        guard let currency = CurrencyWrapper(rawValue: currency)?.currency() else {
            print("Error with currency value.")
            return
        }
        let transaction = CustomerTransaction(id: transactionId, value: Float(price), currency: currency)
        Contentsquare.send(transaction: transaction)
    }
    
    public func sendDynamicVar(dynamicVar: [String: Any]) {
        dynamicVar.forEach { key, value in
            if let value = value as? String {
                do {
                    let dynamicVar = try DynamicVar(key: key, value: value)
                    Contentsquare.send(dynamicVar: dynamicVar)
                } catch {
                    print("Error with dynamic variable key: \(key), value: \(value), error: \(error)")
                }
            } else if let value = value as? UInt32 {
                do {
                    let dynamicVar = try DynamicVar(key: key, value: value)
                    Contentsquare.send(dynamicVar: dynamicVar)
                } catch {
                    print("Error with dynamic variable key: \(key), value: \(value), error: \(error)")
                }
            } else {
                print("Incorrect format of value: \(value). Value should be String or UInt32.")
            }
        }
    }
    
    public func stopTracking() {
        Contentsquare.stopTracking()
    }
    
    public func resumeTracking() {
        Contentsquare.resumeTracking()
    }
    
    public func forgetMe() {
        Contentsquare.forgetMe()
    }
    
    public func optIn() {
        Contentsquare.optIn()
    }
    
    public func optOut() {
        Contentsquare.optOut()
    }
    
//    private
}

/// Maps to Contentsquare's Currency type
public enum CurrencyWrapper : Int, Codable {
    case mop
    case bmd
    case kes
    case bnd
    case iqd
    case sdg
    case zmw
    case xts
    case top
    case xsu
    case svc
    case ils
    case dzd
    case nad
    case mxv
    case sos
    case cad
    case sek
    case hkd
    case zwl
    case egp
    case clp
    case cuc
    case lyd
    case rsd
    case cou
    case cve
    case khr
    case gyd
    case mkd
    case tmt
    case ugx
    case kgs
    case ves
    case ssp
    case npr
    case sbd
    case xpf
    case aud
    case bhd
    case mwk
    case mxn
    case nio
    case lsl
    case xxx
    case zar
    case aoa
    case gmd
    case gip
    case mvr
    case kwd
    case pln
    case mga
    case uah
    case huf
    case rub
    case vnd
    case lak
    case rwf
    case syp
    case xag
    case mur
    case wst
    case xpd
    case gbp
    case etb
    case isk
    case cdf
    case usd
    case tjs
    case cup
    case bgn
    case eur
    case cny
    case cop
    case gnf
    case bbd
    case xua
    case chw
    case xcd
    case lrd
    case pen
    case pkr
    case pyg
    case lkr
    case ron
    case uzs
    case nzd
    case idr
    case ern
    case czk
    case jod
    case awg
    case irr
    case tzs
    case brl
    case ngn
    case che
    case chf
    case bdt
    case thb
    case xdr
    case mad
    case gel
    case fkp
    case azn
    case pab
    case twd
    case aed
    case htg
    case xbd
    case lbp
    case amd
    case php
    case xpt
    case inr
    case bwp
    case myr
    case mnt
    case srd
    case sll
    case uyu
    case bam
    case bif
    case bov
    case jmd
    case omr
    case uyw
    case bzd
    case nok
    case kmf
    case kpw
    case scr
    case jpy
    case xof
    case shp
    case sgd
    case dkk
    case uyi
    case yer
    case ang
    case ttd
    case xbb
    case xbc
    case fjd
    case dop
    case byn
    case kzt
    case xba
    case szl
    case sar
    case gtq
    case pgk
    case ars
    case btn
    case afn
    case djf
    case mdl
    case ghs
    case qar
    case `try`
    case mmk
    case xaf
    case vuv
    case xau
    case clf
    case hrk
    case bob
    case krw
    case bsd
    case all
    case mru
    case hnl
    case stn
    case usn
    case mzn
    case tnd
    case crc
    case kyd
    
    func currency() -> Currency {
        switch self {
        case .mop: return .mop
        case .bmd: return .bmd
        case .kes: return .kes
        case .bnd: return .bnd
        case .iqd: return .iqd
        case .sdg: return .sdg
        case .zmw: return .zmw
        case .xts: return .xts
        case .top: return .top
        case .xsu: return .xsu
        case .svc: return .svc
        case .ils: return .ils
        case .dzd: return .dzd
        case .nad: return .nad
        case .mxv: return .mxv
        case .sos: return .sos
        case .cad: return .cad
        case .sek: return .sek
        case .hkd: return .hkd
        case .zwl: return .zwl
        case .egp: return .egp
        case .clp: return .clp
        case .cuc: return .cuc
        case .lyd: return .lyd
        case .rsd: return .rsd
        case .cou: return .cou
        case .cve: return .cve
        case .khr: return .khr
        case .gyd: return .gyd
        case .mkd: return .mkd
        case .tmt: return .tmt
        case .ugx: return .ugx
        case .kgs: return .kgs
        case .ves: return .ves
        case .ssp: return .ssp
        case .npr: return .npr
        case .sbd: return .sbd
        case .xpf: return .xpf
        case .aud: return .aud
        case .bhd: return .bhd
        case .mwk: return .mwk
        case .mxn: return .mxn
        case .nio: return .nio
        case .lsl: return .lsl
        case .xxx: return .xxx
        case .zar: return .zar
        case .aoa: return .aoa
        case .gmd: return .gmd
        case .gip: return .gip
        case .mvr: return .mvr
        case .kwd: return .kwd
        case .pln: return .pln
        case .mga: return .mga
        case .uah: return .uah
        case .huf: return .huf
        case .rub: return .rub
        case .vnd: return .vnd
        case .lak: return .lak
        case .rwf: return .rwf
        case .syp: return .syp
        case .xag: return .xag
        case .mur: return .mur
        case .wst: return .wst
        case .xpd: return .xpd
        case .gbp: return .gbp
        case .etb: return .etb
        case .isk: return .isk
        case .cdf: return .cdf
        case .usd: return .usd
        case .tjs: return .tjs
        case .cup: return .cup
        case .bgn: return .bgn
        case .eur: return .eur
        case .cny: return .cny
        case .cop: return .cop
        case .gnf: return .gnf
        case .bbd: return .bbd
        case .xua: return .xua
        case .chw: return .chw
        case .xcd: return .xcd
        case .lrd: return .lrd
        case .pen: return .pen
        case .pkr: return .pkr
        case .pyg: return .pyg
        case .lkr: return .lkr
        case .ron: return .ron
        case .uzs: return .uzs
        case .nzd: return .nzd
        case .idr: return .idr
        case .ern: return .ern
        case .czk: return .czk
        case .jod: return .jod
        case .awg: return .awg
        case .irr: return .irr
        case .tzs: return .tzs
        case .brl: return .brl
        case .ngn: return .ngn
        case .che: return .che
        case .chf: return .chf
        case .bdt: return .bdt
        case .thb: return .thb
        case .xdr: return .xdr
        case .mad: return .mad
        case .gel: return .gel
        case .fkp: return .fkp
        case .azn: return .azn
        case .pab: return .pab
        case .twd: return .twd
        case .aed: return .aed
        case .htg: return .htg
        case .xbd: return .xbd
        case .lbp: return .lbp
        case .amd: return .amd
        case .php: return .php
        case .xpt: return .xpt
        case .inr: return .inr
        case .bwp: return .bwp
        case .myr: return .myr
        case .mnt: return .mnt
        case .srd: return .srd
        case .sll: return .sll
        case .uyu: return .uyu
        case .bam: return .bam
        case .bif: return .bif
        case .bov: return .bov
        case .jmd: return .jmd
        case .omr: return .omr
        case .uyw: return .uyw
        case .bzd: return .bzd
        case .nok: return .nok
        case .kmf: return .kmf
        case .kpw: return .kpw
        case .scr: return .scr
        case .jpy: return .jpy
        case .xof: return .xof
        case .shp: return .shp
        case .sgd: return .sgd
        case .dkk: return .dkk
        case .uyi: return .uyi
        case .yer: return .yer
        case .ang: return .ang
        case .ttd: return .ttd
        case .xbb: return .xbb
        case .xbc: return .xbc
        case .fjd: return .fjd
        case .dop: return .dop
        case .byn: return .byn
        case .kzt: return .kzt
        case .xba: return .xba
        case .szl: return .szl
        case .sar: return .sar
        case .gtq: return .gtq
        case .pgk: return .pgk
        case .ars: return .ars
        case .btn: return .btn
        case .afn: return .afn
        case .djf: return .djf
        case .mdl: return .mdl
        case .ghs: return .ghs
        case .qar: return .qar
        case .`try`: return .`try`
        case .mmk: return .mmk
        case .xaf: return .xaf
        case .vuv: return .vuv
        case .xau: return .xau
        case .clf: return .clf
        case .hrk: return .hrk
        case .bob: return .bob
        case .krw: return .krw
        case .bsd: return .bsd
        case .all: return .all
        case .mru: return .mru
        case .hnl: return .hnl
        case .stn: return .stn
        case .usn: return .usn
        case .mzn: return .mzn
        case .tnd: return .tnd
        case .crc: return .crc
        case .kyd: return .kyd
        }
        
    }
}
