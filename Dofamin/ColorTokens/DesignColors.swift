import SwiftUI

class DesignColors: ObservableObject {
    private let theme: Theme

    init(theme: Theme) {
        self.theme = theme
    }

    var bgTransparent1: Color {
        switch theme {
        case .dark:
            return Palette.black60
        case .light:
            return Palette.white50
        }
    }

    var strNeutral4: Color {
        switch theme {
        case .light:
            return Palette.neutral10
        case .dark:
            return Palette.neutral3
        }
    }

    var strDanger1: Color {
        switch theme {
        case .light:
            return Palette.red7
        case .dark:
            return Palette.red4
        }
    }

    var textBrand1: Color {
        switch theme {
        case .dark:
            return Palette.brand4
        case .light:
            return Palette.brand6
        }
    }

    var textSuccess2: Color {
        switch theme {
        case .dark:
            return Palette.green8
        case .light:
            return Palette.green6
        }
    }

    var bgBrandDisabled: Color {
        switch theme {
        case .light:
            return Palette.brand2
        case .dark:
            return Palette.neutral10
        }
    }

    var strNeutral2: Color {
        switch theme {
        case .light:
            return Palette.neutral5
        case .dark:
            return Palette.neutral9
        }
    }

    var textNeutral3: Color {
        switch theme {
        case .light:
            return Palette.neutral8
        case .dark:
            return Palette.neutral5
        }
    }

    var bgWarning1: Color {
        switch theme {
        case .light:
            return Palette.yellow1
        case .dark:
            return Palette.yellow10
        }
    }

    var textNeutralStaticInverted1: Color {
        switch theme {
        case .light:
            return Palette.neutral1
        case .dark:
            return Palette.neutral1
        }
    }

    var bgNeutral3: Color {
        switch theme {
        case .dark:
            return Palette.neutral9
        case .light:
            return Palette.neutral4
        }
    }

    var bgTransparentInverted2: Color {
        switch theme {
        case .dark:
            return Palette.white40
        case .light:
            return Palette.black50
        }
    }

    var bgSuccess1: Color {
        switch theme {
        case .light:
            return Palette.green1
        case .dark:
            return Palette.green10
        }
    }

    var bgBrand1: Color {
        switch theme {
        case .light:
            return Palette.brand6
        case .dark:
            return Palette.brand5
        }
    }

    var strOnBrand1: Color {
        switch theme {
        case .dark:
            return Palette.neutral1
        case .light:
            return Palette.neutral1
        }
    }

    var bgSuccess2: Color {
        switch theme {
        case .light:
            return Palette.green8
        case .dark:
            return Palette.green9
        }
    }

    var bgNeutral4: Color {
        switch theme {
        case .dark:
            return Palette.neutral8
        case .light:
            return Palette.neutral5
        }
    }

    var textDanger2: Color {
        switch theme {
        case .dark:
            return Palette.red5
        case .light:
            return Palette.red5
        }
    }

    var textDisabled: Color {
        switch theme {
        case .light:
            return Palette.neutral6
        case .dark:
            return Palette.neutral8
        }
    }

    var bgNeutralInverted2: Color {
        switch theme {
        case .light:
            return Palette.neutral10
        case .dark:
            return Palette.neutral3
        }
    }

    var textNeutral5: Color {
        switch theme {
        case .dark:
            return Palette.neutral8
        case .light:
            return Palette.neutral6
        }
    }

    var strOnBrand2: Color {
        switch theme {
        case .light:
            return Palette.neutral3
        case .dark:
            return Palette.neutral3
        }
    }

    var bgNeutral2: Color {
        switch theme {
        case .dark:
            return Palette.neutral13
        case .light:
            return Palette.neutral3
        }
    }

    var textBrandDynamicInverted: Color {
        switch theme {
        case .light:
            return Palette.neutral1
        case .dark:
            return Palette.brand6
        }
    }

    var bgNeutralInverted1: Color {
        switch theme {
        case .light:
            return Palette.neutral12
        case .dark:
            return Palette.neutral1
        }
    }

    var textNeutralInverted2: Color {
        switch theme {
        case .light:
            return Palette.neutral3
        case .dark:
            return Palette.neutral10
        }
    }

    var strDanger2: Color {
        switch theme {
        case .dark:
            return Palette.red5
        case .light:
            return Palette.red5
        }
    }

    var strWarning2: Color {
        switch theme {
        case .light:
            return Palette.yellow5
        case .dark:
            return Palette.yellow6
        }
    }

    var textWarning2: Color {
        switch theme {
        case .dark:
            return Palette.yellow6
        case .light:
            return Palette.yellow5
        }
    }

    var bgNeutralStaticInverted1: Color {
        switch theme {
        case .light:
            return Palette.neutral12
        case .dark:
            return Palette.neutral12
        }
    }

    var bgNeutral1: Color {
        switch theme {
        case .dark:
            return Palette.neutral12
        case .light:
            return Palette.neutral1
        }
    }

    var textNeutral2: Color {
        switch theme {
        case .light:
            return Palette.neutral10
        case .dark:
            return Palette.neutral3
        }
    }

    var bgNeutralStaticInverted2: Color {
        switch theme {
        case .light:
            return Palette.neutral10
        case .dark:
            return Palette.neutral10
        }
    }

    var bgDanger2: Color {
        switch theme {
        case .dark:
            return Palette.red8
        case .light:
            return Palette.red7
        }
    }

    var bgBrand3: Color {
        switch theme {
        case .light:
            return Palette.brand1
        case .dark:
            return Palette.brand8
        }
    }

    var textNeutral1: Color {
        switch theme {
        case .dark:
            return Palette.neutral1
        case .light:
            return Palette.neutral12
        }
    }

    var bgDisabled: Color {
        switch theme {
        case .dark:
            return Palette.neutral10
        case .light:
            return Palette.neutral3
        }
    }

    var textBrand2: Color {
        switch theme {
        case .light:
            return Palette.brand4
        case .dark:
            return Palette.brand3
        }
    }

    var bgTransparentStaticInverted1: Color {
        switch theme {
        case .dark:
            return Palette.black50
        case .light:
            return Palette.black50
        }
    }

    var textNeutralStatic1: Color {
        switch theme {
        case .dark:
            return Palette.neutral12
        case .light:
            return Palette.neutral12
        }
    }

    var textNeutralInverted1: Color {
        switch theme {
        case .light:
            return Palette.neutral1
        case .dark:
            return Palette.neutral12
        }
    }

    var textWarning1: Color {
        switch theme {
        case .light:
            return Palette.yellow7
        case .dark:
            return Palette.yellow5
        }
    }

    var textBrandDynamic: Color {
        switch theme {
        case .dark:
            return Palette.neutral1
        case .light:
            return Palette.brand6
        }
    }

    var bgTransparentStatic1: Color {
        switch theme {
        case .light:
            return Palette.white30
        case .dark:
            return Palette.white30
        }
    }

    var strWarning1: Color {
        switch theme {
        case .dark:
            return Palette.yellow5
        case .light:
            return Palette.yellow9
        }
    }

    var strBrand1: Color {
        switch theme {
        case .dark:
            return Palette.brand6
        case .light:
            return Palette.brand6
        }
    }

    var bgNeutralStatic2: Color {
        switch theme {
        case .dark:
            return Palette.neutral3
        case .light:
            return Palette.neutral3
        }
    }

    var bgDanger1: Color {
        switch theme {
        case .light:
            return Palette.red2
        case .dark:
            return Palette.red10
        }
    }

    var textBrand3: Color {
        switch theme {
        case .light:
            return Palette.brand2
        case .dark:
            return Palette.brand1
        }
    }

    var bgTransparentInverted1: Color {
        switch theme {
        case .light:
            return Palette.black60
        case .dark:
            return Palette.white50
        }
    }

    var textNeutral4: Color {
        switch theme {
        case .light:
            return Palette.neutral7
        case .dark:
            return Palette.neutral6
        }
    }

    var textNeutralStaticInverted2: Color {
        switch theme {
        case .light:
            return Palette.neutral3
        case .dark:
            return Palette.neutral3
        }
    }

    var strNeutral1: Color {
        switch theme {
        case .dark:
            return Palette.neutral10
        case .light:
            return Palette.neutral4
        }
    }

    var textSuccess1: Color {
        switch theme {
        case .dark:
            return Palette.green5
        case .light:
            return Palette.green8
        }
    }

    var bgTransparentStatic2: Color {
        switch theme {
        case .dark:
            return Palette.white10
        case .light:
            return Palette.white10
        }
    }

    var textDanger1: Color {
        switch theme {
        case .dark:
            return Palette.red4
        case .light:
            return Palette.red7
        }
    }

    var strSuccess1: Color {
        switch theme {
        case .light:
            return Palette.green8
        case .dark:
            return Palette.green5
        }
    }

    var strDisabled: Color {
        switch theme {
        case .light:
            return Palette.neutral3
        case .dark:
            return Palette.neutral10
        }
    }

    var strSuccess2: Color {
        switch theme {
        case .light:
            return Palette.green6
        case .dark:
            return Palette.green8
        }
    }

    var bgNeutralStatic1: Color {
        switch theme {
        case .light:
            return Palette.neutral1
        case .dark:
            return Palette.neutral1
        }
    }

    var bgBrand2: Color {
        switch theme {
        case .dark:
            return Palette.brand7
        case .light:
            return Palette.brand3
        }
    }

    var textOnBrand: Color {
        switch theme {
        case .light:
            return Palette.neutral1
        case .dark:
            return Palette.neutral1
        }
    }

    var strNeutral3: Color {
        switch theme {
        case .dark:
            return Palette.neutral8
        case .light:
            return Palette.neutral6
        }
    }

    var strBrand2: Color {
        switch theme {
        case .dark:
            return Palette.brand8
        case .light:
            return Palette.brand2
        }
    }

    var textNeutralStatic2: Color {
        switch theme {
        case .light:
            return Palette.neutral9
        case .dark:
            return Palette.neutral9
        }
    }

    var bgWarning2: Color {
        switch theme {
        case .light:
            return Palette.yellow7
        case .dark:
            return Palette.yellow9
        }
    }

    var bgTransparent2: Color {
        switch theme {
        case .light:
            return Palette.white30
        case .dark:
            return Palette.black50
        }
    }

    var bgNeutral5: Color {
        switch theme {
        case .light:
            return Palette.neutral6
        case .dark:
            return Palette.neutral7
        }
    }

    enum Theme {
        case light
        case dark
    }
}
