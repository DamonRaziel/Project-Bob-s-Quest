# Project-Bob-s-Quest
Project Bob's Quest files. 

Project Bob's Quest was built to test my abilities and see what I could learn. It is still a work in progress, and can be used as a base for various mechanics.

Project Bob's Quest is designed to be a 3D action/adventure/platform/RPG game.

Game mechanics include:
Third person follow camera,
Third person over-the-shoulder camera,
Third person movement (move, jump, attack, in 3d space),
Melee and ranged combat,
Enemy A.I. that use navmeshes when not attacking the player,
Variety of enemy types (different attack options),
Simple story mode using an overworld map to move between levels,
Simple arena that spawns waves of enemies,
Simple arena high score board,
Experience points and player upgrades,
Inventory system,
Unlockable characters.

Project Bob's Quest was made combining aspects from a number of other projects (which will be credited and linked soon), such as the inventory and camera controls, the Godot demo templates, and some problem-solving of my own to figure out how things could be done.
It is still a work in progress, as I learn new ways to do new things, but thought I would upload it in case it is useful for anyone else, or if someone has other ideas for how I could implement things.

If you build the project for execution from desktop, you still need to copy across the "Database_Items.json" file, and place it in a folder called "Database" (see folder structure diagram below). I have only tested this on Windows 10 so far, and I am unsure why this needs to be fixed afterwards (I have tried using the Godot project build setting to include json files in the build, but this does not seem to fix it).

Folder structure diagram:

PBQ (Main Folder)-

-Database (Sub Folder)--

   --Database_Items.json (Json File)

-PBQ.exe (Application)

-PBQ.pck (PCK File)


Released under same MIT licence as Godot Game Engine.
https://godotengine.org/license
