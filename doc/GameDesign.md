# Everlasting Candy

This document aims to lay out the underlying spirit of the game and guide future development. Contributions are expected to fall within the project vision outlined here. Evolutions and expansions to this document can also be considered in collaboration with the maintainers.

## Description

Everlasting Candy aims to offer a fun and unique experience by embodying:
 * **Simplicity**. You can pick up this game and get familiar with it in less than one minute. Complexity is low and there aren't many game dynamics to get your head around.
 * **Unconventionality**. It looks like a simple platformer but there are some surprises in store.
 * **A touch of harshness**. The game punishes the player in unusual ways, but only to a light and controlled degree that doesn't feel too unreasonable or annoying.

## Visual Style

The game carries a retro, pixel-art visual style and feel.

## Objective & Dynamics

Each level has one player, and a series of enemies. The player is controlled by the user. The player can move left and right, and jump.

Enemies move left and right, changing direction every time they hit a wall or the end of a platform. Enemies are killed when the player jumps (or falls) on top of them.

_Simplicity:_ The level is passed by killing all the enemies. The game is won when all levels are passed.

_Harshness:_ If the player collides with an enemy via sideways motion, the level is failed. When this happens, the player is penalised by being returned to the level prior to the one they failed, meaning they have to repeat that previously-passed level once again.

_Unconventionality:_ When a player or enemy reaches the right or left edge of the screen, they are automatically "scrolled around" to the opposite edge. When a player drops off the bottom of the screen, they are automatically "scrolled around" to the top.

## Implementation

In addition to being a neat, fun, unconventional little game, this project aims to provide an arena for introductory Godot & Git learning experiences.

The game permits creation of Extra Worlds alongside the main game. A World is a sequence of levels that exists in parallel to the original game. When starting the game, the player can choose to play the original headline game, or to play one of these extra worlds. We envision a great many extra worlds being added to the game.

World & Level creation is intended to be as simple as possible. We wish to enable the creation of these extra worlds without having to read or write any code. Level creation is done by using Godot [TileMapLayer](https://docs.godotengine.org/en/stable/classes/class_tilemaplayer.html), meaning that levels can be created by drag-and-drop usage of TileMaps. Some supporting code is used to automatically convert the player and enemy tiles to dynamic objects that carry out the functions of the game. We strive to make level & world creation as easy as possible and would generally be opposed to game engine changes that increase the difficulty for a future novice contributor to create their own world.

Within each world, contributors are granted creative freedom within the bounds of the game engine. Maintainers will not require or encourage new worlds to maintain the feel, appearance or gameplay of a new world as consistent with that of the original -- each world is treated as independent. At the same time, the addition or modification of one world should not affect the other worlds in any way. The moddability and customisation possibilities for extra worlds are approximately constrained to:
 * Name of the world
 * Level design
 * Visual appearance - the TileSet can be completely reworked to give a new look and feel to the game
 * Start and end screen visual customisation

The range of per-world customisation possibilities can be lightly expanded in future, to increase the creativity permitted within the world-building space:
 * The number of customisations and the steps needed to deploy them should be constrained towards novice contributors. It's important that learners can continue to approach this project, recognise and enjoy the simplicity within, to have the feeling that they can easily fit it within their heads, and to not feel overwhelmed.
 * The playing field should be kept approximately level, such that a novice contributor playing someone else's world has the feeling of "cool, I could have made this myself". This is one reason why we would disallow extra worlds to be enhanced by GDScript coding, for example.
