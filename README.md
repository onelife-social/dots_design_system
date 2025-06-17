## Features
Project with all components on [Figma for Dots Memories App](https://www.figma.com/design/lWkvQH6SyihJ810gHw18WY/Chronicle-Design-System).


## Getting started
All components have the same organization with Figma. Divided by folders.
The structure is this:

```
lib
├── dots_design_system.dart (Exports of all libs)
└── src
     ├── components (Where all components are)
     │     ├── buttons
     │     └── components_lib.dart (Exports of all the components)
     ├── core (All core features)
     └── theme  (Colors and typo)
```

## Usage
# Develop
1. Create a branch from develop to work on it
2. Develop the component or components at this branch
3. Test on example project
4. Test on Dots App (see test on Dots App Project below)
5. Make PR to develop
6. Once all the components for the task/major are done make a new version of the design system (see create new version below)
7. Change the pubspec.yaml to reference the version

# Imports
To export all the need whe use .dart files with the name of the folder followed by '_lib'. e.g. For the folder components we have all exports on 'components_lib.dart' file.

It is important so everything can be imported from the main file 'dots_design_system.dart' otherwise it cannot be accessed from outside the package

# Test on Dots App Project
To test locally you need to change the dependency on pubspec.yaml
 From this:
```yaml
  dots_design_system:
    git:
      url: https://github.com/onelife-social/dots_design_system.git
      ref: v1.0
      
```

To this. Note: the path may differ on each computer
```yaml
  dots_design_system:
    path: ../dots_design_system
      
```

# Create new version of Design system
We use tags for the versions of the design system. This is to avoid breaking develop on main Dots project
The naming of the version is by the type of the changes.
We follow the next logic:
If there are **breaking changes** we add to the first number. e.g. 1.3.1->2.0.0
When we **add new components** the number to add is the middle. e.g. 1.3.1->1.4.0
And if we **fix bugs** we add to the last number. e.g. 1.3.1->1.3.2

Simply create a tag and a new version in GitLab from develop with the name 'vX.X' where X.X is the version. e.g. for the version 1.4 the name of the branch would be 'v1.4'

## Common issues with solutions
# Names conflict
If you have a name conflict with a component, you can use the 'hide' keyword to hide the class. For example for the conflict with method 'dotsWithOpacity':
```dart
import 'package:onelife/app/core/core.dart' hide ColorExtensions;
```

