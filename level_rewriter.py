#!/usr/bin/env python3
import argparse

def rewrite(level_path):
    with open(level_path, "r") as f:
        lines = f.readlines()

    i = lines.index('[node name="TileMapLayer" type="TileMapLayer"]\n')
    lines[i:i+1] = [s + "\n" for s in """
[ext_resource type="Script" path="res://Script/Level.gd" id="1_we7ho"]

[node name="Level" type="Node2D"]
script = ExtResource("1_we7ho")

[node name="Map" type="TileMapLayer" parent="."]
    """.strip().splitlines()
    ]

    lines.extend([
        '\n',
        '[node name="Goobers" type="Node2D" parent="."]\n'
    ])

    with open(level_path, "w") as f:
        for line in lines:
            f.write(line)

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument(metavar="level",
        dest="levels",
        nargs="*"
    )
    args = parser.parse_args()

    for level in args.levels:
        rewrite(level)

if __name__ == "__main__":
    main()
