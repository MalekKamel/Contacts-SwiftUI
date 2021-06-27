# Contacts - SwiftUI

Contacts app represents a real world app example. it provides a fairly complex set of functionalities. It's a suitable showcase for all the advantages that SwiftUI, Combine, and modular architecture bring. It has all features that would make it a modular, scalable, testable and maintainable app.

## App Logic

- The app displays the list of user’s contacts that are saved in `Realm` local database.
- If there's no data in `Realm`, it will be retrieved from contacts `CNContactStore` and saved locally in `Realm`.
- The local contacts are synchronized with `CNContactStore` in background every 15 minutes using `BGTaskScheduler`.
- The local contacts are synchronized every time the user opens the app.

 ## Modular Architecture
 
 <img src="https://github.com/ShabanKamell/Contacts-SwiftUI/blob/master/blob/modular-arch-diagram.png?raw=true" height="600">
 
 
 ## Stack:
 - [ ] SwiftUI
 - [ ] Combine
 - [ ] RxSwift
 - [ ] CombineMoya
 - [ ] MVVM
 - [ ] Modular architecture

 ## README

Each module has its own `README.md` file that documents the module.

 ### 🛡 License
<details>
    <summary>
        Click to reveal License
    </summary>
    
```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
