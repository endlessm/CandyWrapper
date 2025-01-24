## Adding New Worlds

First, choose a name for your new world. This should be as descriptive and creative as you like - this is the name that will appear on the world selection menu. You can use spaces and any other characters that are permitted within filenames. Below we will use name “Flying Cow Party” as an example.

Copy the `Worlds/Sample` folder to `Worlds/Flying Cow Party`. You can do this from Godot's FileSystem view by right clicking on `Sample` and selecting `Duplicate`. Run the game: you should see “Flying Cow Party” in the world selection menu.

Now, you can adapt the existing sample levels and add new ones within `Worlds/Flying Cow Party`. The levels will be sequenced through a case-insensitive, natural order sorting of their filenames. In other words, if you maintain the naming scheme of `1.tscn`, `2.tscn`, `3.tscn` and so on, the levels will play in this order.

Each level should be a numbered scene file, with a single `TileMapLayer` node. Each level should have the player tile in exactly one cell, and one or more “goober” tiles. When the level is played, they will be replaced with the player and goober scenes, offset horizontally by half a tile.

The first level in the sequence (typically `0.tscn`) is treated as the start screen. This level is treated specially by the game: the player cannot move, and pressing Jump starts the game proper. Similarly, the final level (typically `999.tscn`) is treated as the end screen.

A core part of the game is that the levels wrap around: if the player or enemies move off any of the four sides of the screen, they reappear on the opposite side. For this to work correctly, you currently need to manually copy any ledges that are at the edge of the tile map to the corresponding position just off the other edge of the map. See https://github.com/endlessm/everlasting-candy/issues/19 for more details.

## Customizing your world

### Start, end and level progression screens

1. Copy `Image/Title.png` into your world's folder.

2. Use a graphical editor to make any desired changes to these screens.

3. Open your world's `World.tscn` file in the Editor's 2D view.

4. Select the `Overlay` node from the Scene Dock. In the Inspector, observe where the Sprite2D Texture is shown.

5. From the FileSystem dock, locate your world's modified `Title.png` file. Drag that file to the Sprite2D Texture section of the Inspector.

Now your customised start, end and level progression screens will be used in your world.

### TileSet

1. Copy `Image/Tilemap.png` into your world's folder.

2. Use a graphical editor to make any desired changes to these graphics.

3. Open the first level in your world in the Editor's 2D view.

4. Select the `TileMapLayer` from the Scene Dock. In the Inspector, locate the `Tile Set` option under `TileMapLayer`.

5. Click the ⌄ there and select `Save As`. Save the resultant `TileSet.tres` in your world's folder.

6. Click `TileSet` in the bottom pane, and click `Tilemap.png` as shown within. Observe where it shows the `Texture` option under `Setup`.

7. From the FileSystem dock, locate your world's modified `Tilemap.png` file. Drag that file to the Texture section that you just located.

Now your customised tilemap is available for use in your level.

You will also need to apply your customised `TileSet.tres` to all other levels in your world:

1. Open the next level in the Editor's 2D view.

2. Select the `TileMapLayer` from the Scene Dock. In the Inspector, locate the `Tile Set` option under `TileMapLayer`.

3. Locate your world's `TileSet.tres` in the FileSystem view.

4. Drag `TileSet.tres` over to the `Tile Set` option in the Inspector that you just located.

### Music

1. Open your world's `World.tscn` file in the Editor's 2D view.

2. Select the `Music` node from the Scene Dock.

3. Use the Inspector to customise the music playback options or to use a different audio file.

### Sound effects

1. Open your world's `World.tscn` file in the Editor's 2D view.

2. Select the `Win` or `Lose` Audio node from the Scene Dock.

3. Use the Inspector to customise the playback options or to use a different audio file.

## Contributing your world

Once your world is at a suitable point for initial contribution, please submit it to Everlasting Candy as a GitHub Pull Request.

The commits within your Pull Request should consist only of the addition of your world. You must not include any unrelated changes.

When creating your Pull Request, please pay particular attention to the Pull Request title and description. When your contribution is accepted, all commits in your Pull Request will be squashed into a single commit, which will adopt the title and description from the Pull Request. Your Pull Request should have an imperative title such as "Add Flying Cow World", and the description should briefly explain the key features of your contribution and the reasons behind any key decisions. See [How to Write a Git Commit Message](https://cbea.ms/git-commit/) for more details on the basic linguistic and content standards to follow.

Please also post a follow-up comment on your Pull Request with screenshots or a video showing your world in action. This is optional but recommended. Showcase your contribution!

Your Pull Request may receive feedback from maintainers and peers. In order to respond to this feedback, you do not need to create a new branch or open a new Pull Request. Please continue working on the same branch, and the existing Pull Request will automatically update. You can either address feedback by creating followup commits (they will later be squashed), or by modifying and force-pushing the original commits.

Once your contribution gets accepted into the main game, it is recommended that you delete your branch from your forked repository and any local clones. This is because the commit squashing process will effectively replace your contribution with a *new* commit with a different ID, so it will be easy to get confused if you keep the old version around.
