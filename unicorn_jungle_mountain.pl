#!/usr/bin/perl

# This program will find all the paths between two shelters
# in a given map.

use strict;
use warnings;

# Define map size
my $m = 5;
my $n = 5;

# Define starting and ending shelters
my $startX = 1;
my $startY = 2;
my $endX = 3;
my $endY = 4;

# Create a 2D array for the map
my @map = (
    [1,0,1,1,1],
    [0,1,1,0,1],
    [0,1,0,1,0],
    [1,1,1,0,1],
    [1,0,1,1,1]
);

# Initialize an empty path array
my @path;

# Recursive function to find all paths
my $maxPaths = 0;
findPaths($startX, $startY);

# Output all paths
for my $p (0..scalar(@path) - 1) {
    my @curPath = @{$path[$p]};
    print join("->", map { "$_->[0],$_->[1]" } @curPath) . "\n"
}

# Find all paths using the recursive function
sub findPaths {
    # Get X,Y coordinates
    my ($x, $y) = @_;

    # Push current coordinates to the path array
    push(@path, [$x, $y]);

    # If the current coordinates are the endpoint, increment the path count
    if ($x == $endX && $y == $endY) {
        $maxPaths++;
        return;
    }

    # Mark the map cell as visited
    $map[$x][$y] = 0;

    # Traverse upwards
    if ($x - 1 >= 0 && $map[$x - 1][$y] == 1) {
        findPaths($x - 1, $y);
    }

    # Traverse downwards
    if ($x + 1 < $m && $map[$x + 1][$y] == 1) {
        findPaths($x + 1, $y);
    }

    # Traverse leftwards
    if ($y - 1 >= 0 && $map[$x][$y - 1] == 1) {
        findPaths($x, $y - 1);
    }

    # Traverse rightwards
    if ($y + 1 < $n && $map[$x][$y + 1] == 1) {
        findPaths($x, $y + 1);
    }

    # Backtrack and pop the coordinates from the path array
    pop(@path);
}