//
//  Slope.swift
//  StudyiOS
//
//  Created by nylah.j on 2023/10/05.
//


#if canImport(WWDC_Macro)
import WWDC_Macro
#endif

// Slopes in my favorite ski resort.
enum Slope {
    case beginnersParadise
    case practiceRun
    case livingRoom
    case olympicRun
    case blackBeauty
 }

// MARK: - @attached 매크로
// Slopes suitable for beginners. Subset of 'Slopes'.
// EasySlope와 Slope를 상호변환할 수 있는 intiailzer, property 존재
// -> Slope에 case가 추가되면 자동으로 initizlier에 case가 추가되도록 하기!!
// -> intizlier를 매크로로 만든다.
//enum EasySlope {
//    case beginnersParadise
//    case practiceRun
//    
//    init?(_ slope: Slope) {
//        switch slope {
//        case .beginnersParadise: self = .beginnersParadise
//        case .practiceRun: self = .practiceRun
//        default: return nil
//        }
//    }
//    
//    var slope: Slope {
//        switch self {
//            case .beginnersParadise: return .beginnersParadise
//            case .practiceRun: return .practiceRun
//        }
//    }
//}

#if canImport(WWDC_Macro)
@SlopeSubset
enum EasySlope {
    case beginnerParadise
    case particeRun
}
#endif
