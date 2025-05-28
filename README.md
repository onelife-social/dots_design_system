## Features
Project with all components on Figma for Dots Memories App.

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
We use branches as versions of the design system. This is to avoid breaking develop on main Dots project
The naming of the version is by the changes. If there are no breakable changes, only add to the minor version. e.g. 1.3->1.4. If there are breakable changes add to major version. e.g. 1.3->2.0

Simply create a branch from develop with the name 'vX.X' where X.X is the version. e.g. for the version 1.4 the name of the branch would be 'v1.4'


