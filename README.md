# Angry Animals 🐦

An Angry Birds-style game developed in Godot 4.4+ as part of the **"Jumpstart to 2D Game Development: Godot 4.4+ for Beginners"** course.

## 🎮 About the Game

Angry Animals is a 2D physics game where you control a bird (animal) and must destroy all cups in the level using the minimum number of attempts possible. The game combines realistic physics mechanics with strategy and precision.

## 🎯 Game Mechanics

### Launch System
- **Drag and Drop**: Click and drag the animal to set the direction and force of the launch
- **Direction Arrow**: An arrow shows the direction and intensity of the launch
- **Drag Limits**: Dragging is limited to keep the game balanced
- **Impulse System**: The applied force is calculated based on the drag distance

### Scoring System
- **Minimum Attempts**: The goal is to destroy all cups with the minimum number of attempts
- **Best Score System**: Each level saves its best score
- **Data Persistence**: Scores are saved locally

### Physics System
- **RigidBody2D**: The animal uses Godot's realistic physics
- **Collisions**: Collision detection system between animal, cups, and water
- **Gravity**: Gravity physics applied to the animal after launch

## 🏗️ Project Architecture

### Folder Structure
```
Scenes/
├── Animal/          # Animal scripts and scenes
├── LevelBase/       # Level base system
├── LevelButton/     # Level selection buttons
├── GameUI/          # User interface
├── Cup/             # Destructible objects
└── Water/           # Water area

Globals/
├── SignalHub.gd     # Global signal system
└── ScoreManager.gd  # Score management

Classes/
└── LevelScoreResource.gd  # Score data resource
```

### Main Components

#### 🐦 Animal (animal.gd)
- **States**: Ready, Drag, Release
- **Controls**: Mouse input for drag and drop
- **Physics**: Impulse application based on drag
- **Audio**: Sound effects for stretch, launch, and kick

#### 🏆 Scoring System (ScoreManager.gd)
- **Autoload**: Globally available
- **Persistence**: Save/load scores to file
- **Levels**: Multi-level support

#### 📡 Signal System (SignalHub.gd)
- **Communication**: Event system between components
- **Events**: Animal died, cup destroyed, attempt made

## 🎵 Audio Resources

The game includes several sound effects:
- **Birdsong**: Ambient sound
- **Catapult**: Launch sound
- **Stretch**: Sound during drag
- **Kick Wood**: Impact sound
- **Splash**: Water sound
- **Vanish**: Destruction sound

## 🎨 Visual Resources

- **Sprites**: Bird, cups, environment elements
- **Backgrounds**: Themed scenarios
- **UI**: Styled panels and buttons
- **Animations**: Destruction effects and transitions

## 🚀 How to Play

1. **Level Selection**: Choose a level in the main menu
2. **Launch**: Click and drag the animal to set direction and force
3. **Objective**: Destroy all cups with the minimum number of attempts
4. **Strategy**: Use physics to your advantage for ricochets and combos