# BoutTime

> Project - 03: Bout Time game

## Introduction

The goal of the game is to sort events in the chronological order. The player Has
60 seconds per round to try to sort events. A single game is composed of 6 rounds.
Each round has 4 events to sort.

The player win 1 point when 4 events are sorted correctly, 0 when at least one is
in error.

The oldest event is always on top and the newest event is on the bottom of the screen.

The player can shake the phone to end round and ask for events to be evaluated.

At the end of the game, the player will see its score and the maximum score.

At the end of a round, the player can touch an event to open a wiki page with the book
details. During the play, it's not possible otherwise, it will be easier to order the
events.

## Additional precisions

The events in this game are the Star Wars books. The event criteria to sort the events
is the year in the Star Wars timeline. The year 0 is based on the Battle of Yavin where
first Death Star was destroyed. So for example:

- Star Wars I: A New Hope  -> Year 0
- Star Wars II: The Empire Strikes Back -> Year 3
- Star Wars III: The Return of the Jedi -> Year 4

Sometimes, several books take place in the same year in this timeline. But, there are
always sortable in the timeline. To differentiate, an additional order attribute is used.

Therefore, all the events in the game have a unique place in the timeline.
