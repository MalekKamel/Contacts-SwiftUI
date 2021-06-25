## SwiftLint
#$PODS_ROOT/SwiftLint/swiftlint --config $PROJECT_DIR/../swiftlint.yml

# SwiftGen
$PODS_ROOT/SwiftGen/bin/swiftgen xcassets -t swift4 $PROJECT_DIR/$PROJECT_NAME/Resources/Assets.xcassets  $PROJECT_DIR/$PROJECT_NAME/Resources/Colors.xcassets -o $PROJECT_DIR/$PROJECT_NAME/Resources/Assets.swift

# Core Module
$PODS_ROOT/SwiftGen/bin/swiftgen xcassets -t swift4 $PROJECT_DIR/Common/Core/Core/Resources/Assets.xcassets  $PROJECT_DIR/Common/Core/Core/Resources/Colors.xcassets -o $PROJECT_DIR/Common/Core/Core/Resources/Assets.swift
$PODS_ROOT/SwiftGen/bin/swiftgen strings -t structured-swift4 $PROJECT_DIR/Common/Core/Core/Resources/Localizations/en.lproj/Localizable.strings -o $PROJECT_DIR/Common/Core/Core/Resources/L10n.swift --param publicAccess

# Data Module
$PODS_ROOT/SwiftGen/bin/swiftgen xcassets -t swift4 $PROJECT_DIR/Common/Data/Data/Resources/Assets.xcassets  $PROJECT_DIR/Common/Data/Data/Resources/Colors.xcassets -o $PROJECT_DIR/Common/Data/Data/Resources/Assets.swift

# Presentation Module
$PODS_ROOT/SwiftGen/bin/swiftgen xcassets -t swift4 $PROJECT_DIR/Common/Presentation/Presentation/Resources/Assets.xcassets  $PROJECT_DIR/Common/Presentation/Presentation/Resources/Colors.xcassets -o $PROJECT_DIR/Common/Presentation/Presentation/Resources/Assets.swift
